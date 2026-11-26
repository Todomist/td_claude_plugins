---
name: decide
description: Record a tech decision in .claude/td-codecraft/stack.md - a library, a pattern, a convention, a service, or a change to one - with its reason and date. Use when a chat settles a tech question, when the owner approves a library, or when an earlier decision is replaced.
---

# Record a decision

1. Read `.claude/td-codecraft/stack.md`. If it is missing, suggest `/td-codecraft:init` and stop.
2. Write the entry: the next ID (`D<n>`), today's date (`26 Nov 2026`), the decision in one line,
   why, and the decision it replaces, if any. Show it, with every other place it changes
   `stack.md` (a Stack or Conventions row, an approved library) and whether the project's
   `.claude/td-codecraft/code-rules.md` needs a line too. Wait for "yes".
3. Write it. Never delete a decision: the one it replaces stays, marked "replaced by D<n>".
