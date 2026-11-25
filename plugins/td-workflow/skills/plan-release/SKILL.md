---
name: plan-release
description: How a release is planned in numbered branches and how each branch is sized, how the branch plan, the todos and the status file are kept, and how releases and versions work. Use when planning a release or a branch, adding a todo, after a branch is merged, and when cutting a release.
---

Read `plan-release.md` in this folder (`${CLAUDE_PLUGIN_ROOT}/skills/plan-release/`) in full
and follow it. The project's values (work branch, release branch, run it, status, branch plan,
todos, extra planning rules) are in the **This project** table of `.claude/how-we-work.md`. If the
project names extra planning rules, read them too: they come on top of these.

If the project has no **This project** table, stop and ask the owner to add one (template:
`${CLAUDE_PLUGIN_ROOT}/templates/this-project.md`).

- Show a plan in the chat first. Change the branch plan, the todos or the status file only after
  the owner's "yes".
- Commits inside a branch are `/td-workflow:commit-rules`.
