---
name: recall
description: Search team memories from Mneme. Use when starting work on a problem, debugging an issue, or looking for prior decisions and patterns. Automatically invoked when context suggests relevant team knowledge may exist.
---

# Recall

Search Mneme for relevant team memories using `mcp__mneme__search_memories`.

## When to use

- Starting work on a feature or bug — check if there's prior context
- Debugging an issue — search for similar past issues
- Making a design decision — check if this was decided before
- Onboarding to a new area of the codebase — find documented patterns

## How to search

1. Formulate a natural language query based on the task at hand
2. Call `mcp__mneme__search_memories` with the query
3. Optionally filter by `repo` if you know which repo is relevant
4. Review results — memories include confidence scores, keywords, entity references, and provenance (who created it, from which tool/session)
5. Apply relevant findings to the current task

## Search tips

- Use specific terms: "prisma transaction deadlock" not "database issues"
- Include the technology/framework: "Next.js app router caching" not "caching problem"
- Reference file names or function names if known
- Try multiple queries if the first doesn't surface what you need

## Arguments

If invoked as `/mneme:recall <query>`, use `$ARGUMENTS` as the search query. If no arguments provided, infer the best search query from the current conversation context.
