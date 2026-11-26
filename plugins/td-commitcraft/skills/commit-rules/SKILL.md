---
name: commit-rules
description: How commits are planned, sized, ordered and named, where debug logs and review changes go, and the end-of-branch steps. Use before the first commit of a branch, when committing, and when finishing a branch.
---

Read `commit-rules.md` in this folder (`${CLAUDE_PLUGIN_ROOT}/skills/commit-rules/`) in full
and follow it. The project's values (work branch, branch names, checks, run it, docs, paid
services, local review branch, review script, log prefix) are in the **This project** table of
`.claude/td-commitcraft/project.md`. If `.claude/td-commitcraft/commit-rules.md` exists, read it too:
the project's own rules for this skill, which win where they differ.

If the project has no `.claude/td-commitcraft/project.md` with a **This project** table, stop
and suggest `/td-commitcraft:init`.

Before the first commit of a branch, tell the owner how many commits it needs and what each
holds, and wait for "yes".

Unless the table names another review script, it is the one bundled with this plugin. The
command for the owner, with the work branch as the base:
`bash "${CLAUDE_PLUGIN_ROOT}/skills/review-commits/review-commits.sh" <work branch>`.
