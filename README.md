# Mneme — Claude Code Plugin

Persistent team memory for AI coding agents. Captures decisions, patterns, bugs, and conventions automatically — searchable across repos and sessions.

## Install

```
/plugin marketplace add MnemeAI/claude
/plugin install mneme
```

Then run `/mneme:setup` to connect your API key.

## Skills

| Skill | Description |
|-------|-------------|
| `/mneme:setup` | Configure Mneme MCP connection |
| `/mneme:memorize` | Extract and save learnings from the current session |
| `/mneme:recall <query>` | Search team memories for prior decisions, patterns, and bugs |

## Hooks

- **PreCompact** — Checks for unsaved memory-worthy events before context compaction
- **PostToolUseFailure** — Saves memories to local fallback if Mneme API is unreachable
- **Stop** — Reminds you to save learnings at the end of a session

## Get an API Key

Sign up at [mnem.dev](https://mnem.dev) and create a key in your [dashboard settings](https://mnem.dev/dashboard/settings).

## Alternative Setup

For Cursor, Codex CLI, and Windsurf support, use the universal installer:

```bash
curl -fsSL https://mnem.dev/setup | bash
```

## Learn More

- [Documentation](https://mnem.dev/docs)
- [Dashboard](https://mnem.dev/dashboard)
