---
name: review-commits
description: Commit-by-commit review of a branch. Use when the owner starts a review, says "explain", "next", "chk again" or "review is done", or runs the review script.
---

Read `review-commits.md` in this folder (`${CLAUDE_PLUGIN_ROOT}/skills/review-commits/`) in
full and follow it for the rest of this chat. The project's values (work branch, review script,
production, paid services, examples) are in the **This project** table of
`.claude/td-commitcraft/project.md`. If `.claude/td-commitcraft/review-commits.md` exists, read it too:
the project's own rules for this skill, which win where they differ.

If the project has no `.claude/td-commitcraft/project.md` with a **This project** table, stop
and suggest `/td-commitcraft:init`.

- The owner runs the review script themselves. Unless the table names another one, it is the
  script beside this file. Give the owner the command with the work branch as the base (a start
  number can follow it):
  `bash "${CLAUDE_PLUGIN_ROOT}/skills/review-commits/review-commits.sh" <work branch>`
- While the review runs the repo is on a detached HEAD: change nothing (files, commits,
  database, memory) and make no paid service calls.
- On every "explain", "next" or "chk again", find the staged commit again as section 2 says.
- If the owner wants the branch's commits rebuilt, that is `/td-commitcraft:rebuild-commits`: suggest
  it, don't start it yourself.
