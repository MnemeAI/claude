---
name: memorize
description: Extract and persist learnings from the current session to Mneme. Use at end of session, after a milestone, or when you want to capture what you've learned.
---

# Memorize

Extract learnings from this session and persist them to Mneme using `mcp__mneme__create_memory`.

## What to extract

Scan the conversation for:

1. **Bug fixes** — root cause, fix, prevention (type: `issue`, category: `code-quality`)
2. **Architectural decisions** — what was chosen, rejected, why (type: `decision`, category: `architecture`)
3. **Non-obvious patterns** — codebase quirks that took investigation (type: `pattern`)
4. **Conventions established** — "always use X for Y" (type: `convention`)
5. **Debugging dead-ends** — what looked right but wasn't (type: `issue`)
6. **User preferences** — workflow/tool preferences (type: `preference`)

## How to write good memories

- **Self-contained** — must make sense without session context
- **Specific** — include file paths, function names, error messages, version numbers
- **Why, not just what** — "we chose X because Y" not just "we use X"
- **One idea per memory** — don't bundle unrelated things

## Parameters

- **repo**: Detect from git remote or cwd (format: `owner/repo`)
- **category**: Most specific match. When in doubt: `architecture` for design, `code-quality` for bugs, `infrastructure` for CI/deploy, `security` for auth
- **keywords**: 3-5 terms someone might search for
- **entity_refs**: Link to relevant PRs, issues, files when available

### Provenance (always include)

- **author**: Detect from `git config user.name` or conversation context
- **source_tool**: `"claude-code"`

## What NOT to memorize

- Session-specific temporary state
- Obvious/well-known patterns
- Anything already in CLAUDE.md or project docs
- Speculative conclusions from incomplete investigation
- Personal information or credentials

## Process

1. Review the conversation for memory-worthy events
2. Draft each memory with all required fields
3. Call `mcp__mneme__create_memory` for each
4. If the API fails, note the failure — the PostToolUse hook will save it locally as a fallback
5. Report what was saved
