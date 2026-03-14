---
name: setup
description: Configure or reconfigure Mneme MCP server connection. Use when setting up Mneme for the first time, changing API keys, or troubleshooting connection issues.
---

# Setup Mneme

Configure the Mneme MCP server for persistent team memory. If Mneme is already configured, this will verify the connection and update settings if needed.

## Instructions

### Step 1: Check existing config

Run this command to check if Mneme is already configured:

```bash
jq '.mcpServers.mneme // empty' ~/.claude.json 2>/dev/null
```

- If it returns a non-empty object: tell the user Mneme is already configured. Ask if they want to reconfigure (new API key, different server URL).
- If it returns empty or the file doesn't exist: continue to Step 2.

### Step 2: API key

If the user provided an API key as `$ARGUMENTS`, use it. Otherwise ask:

> You need a Mneme API key. If you already have one, paste it here. Otherwise visit https://mnem.dev/dashboard/settings to create one.

Validate the key starts with `mneme_`. If it doesn't, tell the user the key format is invalid (Mneme keys always start with `mneme_`) and ask them to try again.

### Step 3: Detect project

Run `git remote get-url origin` to detect the current repo. Extract `owner/repo` from the URL (strip `.git` suffix and host prefix).

### Step 4: Configure MCP server

Read `~/.claude.json` (create with `{}` if missing). Add or update ONLY the `mcpServers.mneme` entry, preserving all other content:

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

Replace `<API_KEY>` with the actual key.

### Step 5: Verify connection

Try calling `mcp__mneme__search_memories` with query "test". If the MCP server isn't connected yet, tell the user to run `/mcp` to connect, then retry.

- **Success**: connection verified (empty results are fine — it means the connection works but no memories exist yet)
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
