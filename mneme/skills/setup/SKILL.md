---
name: setup
description: Configure or reconfigure Mneme MCP server connection. Use when setting up Mneme for the first time, changing API keys, or troubleshooting connection issues.
---

# Setup Mneme

Configure the Mneme MCP server for persistent team memory. If Mneme is already configured, this will verify the connection and update settings if needed.

## Instructions

### Step 1: Check existing config

Read `~/.claude.json` and check if `mcpServers.mneme` already exists.

- If it exists and MCP is connected: tell the user Mneme is already configured. Ask if they want to reconfigure (new API key, different server URL).
- If it doesn't exist or user wants to reconfigure: continue to Step 2.

### Step 2: API key

If the user provided an API key as `$ARGUMENTS`, use it. Otherwise ask:

> You need a Mneme API key. If you already have one, paste it here. Otherwise visit https://mnem.dev/dashboard/settings to create one.

Validate the key starts with `mneme_`.

### Step 3: Detect project

Run `git remote get-url origin` to detect the current repo. Extract `owner/repo` from the URL.

### Step 4: Configure MCP server

Read `~/.claude.json` (create with `{}` if missing). Add or update `mcpServers.mneme`:

```json
{
  "mcpServers": {
    "mneme": {
      "type": "http",
      "url": "https://mneme.fly.dev/mcp",
      "headers": {
        "Authorization": "Bearer <API_KEY>"
      }
    }
  }
}
```

Replace `<API_KEY>` with the actual key. Preserve all existing entries.

### Step 5: Verify connection

Try calling `mcp__mneme__search_memories` with query "test". If the MCP server isn't connected yet, tell the user to run `/mcp` to connect, then retry.

- **Success**: connection verified
- **Auth error**: key invalid — check https://mnem.dev/dashboard/settings
- **Connection error**: suggest `/mcp` to connect, then retry

### Step 6: Done

```
Mneme is configured!

Skills:
  /mneme:recall <query>  — search team memories
  /mneme:memorize        — save learnings from this session
  /mneme:setup           — reconfigure (you are here)

Dashboard: https://mnem.dev/dashboard
```
