---
name: map
description: Write or refresh .claude/td-codecraft/map.md, the reference for what an existing project contains and where it lives - what it is, its apps and packages, features, tables, API routes, screens, outside services and docs. Use when a project has no map yet, when a branch adds or removes a feature, a table, a route or a screen, or when the owner asks where something lives.
---

# Map the project

`map.md` says what the project is and where everything lives, one line per item, so Claude and
the owner can look things up instead of searching the code. It points to the project's deeper
docs instead of repeating them. Nothing is written until the owner says "yes".

## 1. Scan

Read the repository, not memory: the folder layout and package files; the server's modules and
their routes; the migrations (the tables they create and change); the app's routes, screens and
features; env examples and configs (outside services); the project's docs folder and its index;
`CLAUDE.md`, `.claude/td-codecraft/stack.md` and `.claude/td-commitcraft/project.md` if they
exist.

## 2. Show

- **No map yet:** show the whole file, from `${CLAUDE_PLUGIN_ROOT}/templates/map.md`.
- **A map exists:** show only what changed since its "Mapped" line: items added, removed or
  moved, each with the file it comes from. Never drop a line written by hand without saying so.
- Every line names the path it comes from. What you cannot place goes under "Open questions" in
  the chat, never into the file.
- Keep it short: one line per item. Anything longer belongs in the project's docs, linked from the
  map.
- Don't repeat a list the project already keeps. When its docs already list the tables, the
  routes or the docs (an index file such as `docs/db/README.md`), link that file under Data, API
  or Docs in one line instead. One line per item only where no such list exists.

## 3. Write after "yes"

Write `.claude/td-codecraft/map.md` and set its "Mapped" line to today's date (`26 Nov 2026`) and
the commit it was mapped at (`git rev-parse --short HEAD`). Don't commit: list the changed file
and suggest the project's commit rules (`/td-commitcraft:commit-rules` if it is available).
