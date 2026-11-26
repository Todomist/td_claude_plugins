# Changelog

## 0.1.0

- First version: `init`, `decide` and `code-rules`. The code rules are the ones our projects
  shared (code, database, API, app), in one wording; each project's choices and values go into
  its `.claude/td-codecraft/stack.md`, and its own rules into `.claude/td-codecraft/code-rules.md`.
- A `SessionStart` hook reminds Claude when to suggest `code-rules` and `decide`.
