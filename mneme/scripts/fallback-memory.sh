#!/bin/bash
# PostToolUse handler for mcp__mneme__create_memory failures.
# When Mneme API fails, save the memory locally so nothing is lost.

set -euo pipefail

INPUT=$(cat)

# Check if this was an error (tool_result contains error info)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
if [ "$TOOL_NAME" != "mcp__mneme__create_memory" ]; then
  exit 0
fi

IS_ERROR=$(echo "$INPUT" | jq -r '.tool_result.is_error // false')
if [ "$IS_ERROR" != "true" ]; then
  exit 0
fi

# Extract the memory content from the tool input
CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // empty')
REPO=$(echo "$INPUT" | jq -r '.tool_input.repo // "unknown"')
TYPE=$(echo "$INPUT" | jq -r '.tool_input.type // "issue"')
KEYWORDS=$(echo "$INPUT" | jq -r '.tool_input.keywords // [] | join(", ")')
ERROR=$(echo "$INPUT" | jq -r '.tool_result.content // "unknown error"')

if [ -z "$CONTENT" ]; then
  exit 0
fi

# Determine the fallback file location
MEMORY_DIR="${CLAUDE_PROJECT_DIR:-.}/.claude/memory"
mkdir -p "$MEMORY_DIR"
FALLBACK_FILE="$MEMORY_DIR/mneme-fallback.md"

# Append the memory with metadata
{
  echo ""
  echo "## [${TYPE}] $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "**Repo:** ${REPO}"
  if [ -n "$KEYWORDS" ]; then
    echo "**Keywords:** ${KEYWORDS}"
  fi
  echo "**Fallback reason:** ${ERROR}"
  echo ""
  echo "$CONTENT"
  echo ""
  echo "---"
} >> "$FALLBACK_FILE"

exit 0
