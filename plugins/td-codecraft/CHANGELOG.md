# Changelog

## 0.1.1

- New `map`: writes or refreshes `.claude/td-codecraft/map.md`, what an existing project
  contains and where it lives (features, tables, routes, screens, outside services, docs), one
  line per item with its path. `code-rules` reads it when it exists, and the hook suggests it when
  a branch adds a feature, a table, a route or a screen.

## 0.1.0

- First version: `init`, `decide` and `code-rules`. The code rules are the ones our projects
  shared (code, database, API, app), in one wording; each project's choices and values go into
  its `.claude/td-codecraft/stack.md`, and its own rules into `.claude/td-codecraft/code-rules.md`.
- A `SessionStart` hook reminds Claude when to suggest `code-rules` and `decide`.
