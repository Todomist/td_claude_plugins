---
name: review-commits
description: Commit-by-commit review of a branch. Use when the owner starts a review, says "explain", "next", "chk again" or "review is done", or runs the review script.
---

Read `review-commits.md` in this folder (`${CLAUDE_PLUGIN_ROOT}/skills/review-commits/`) in
full and follow it for the rest of this chat. The project's values (main branch, review script,
production, paid services, examples) are in the **This project** table of
`.claude/how-we-work.md`.

If the project has no **This project** table, stop and ask the owner to add one (template:
`${CLAUDE_PLUGIN_ROOT}/templates/this-project.md`).

- The owner runs the review script themselves. Unless the table names another one, it is the
  script beside this file. Give the owner the command with the main branch as the base (a start
  number can follow it):
  `bash "${CLAUDE_PLUGIN_ROOT}/skills/review-commits/review-commits.sh" <main branch>`
- While the review runs the repo is on a detached HEAD: change nothing (files, commits,
  database, memory) and make no paid service calls.
- On every "explain", "next" or "chk again", find the staged commit again as section 2 says.
- If the owner wants the branch's commits rebuilt, that is `/workflow:rebuild-commits`: suggest
  it, don't start it yourself.
