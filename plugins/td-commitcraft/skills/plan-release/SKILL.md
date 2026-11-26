---
name: plan-release
description: How a release is planned in numbered branches and how each branch is sized, how the branch plan, the todos (one table, with Done dates) and the status file are kept, and how a release is cut, shipped, versioned and filed in its own folder. Use when planning a release or a branch, adding or closing a todo, after a branch is merged, and when cutting or shipping a release.
---

Read `plan-release.md` in this folder (`${CLAUDE_PLUGIN_ROOT}/skills/plan-release/`) in full
and follow it. The project's own values (work branch, run it, status, branch plan, todos,
releases folder, release branch, extra planning rules) are in the **This project** table of
`.claude/how-we-work.md`.

If the project has no `.claude/how-we-work.md`, or it has no **This project** table, stop and
ask the owner to add it from the template: `${CLAUDE_PLUGIN_ROOT}/templates/how-we-work.md`.

- Show a plan in the chat first. Change the branch plan, the todos or the status file only after
  the owner's "yes".
- Commits inside a branch: `/td-commitcraft:commit-rules`.
