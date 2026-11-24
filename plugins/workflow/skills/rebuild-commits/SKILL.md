---
name: rebuild-commits
description: Rebuild a branch's commits into a clean sequence (core first, then one complete feature per commit) before a commit-by-commit review. Use only when the owner asks to restructure, rebuild or recreate a branch's commits.
---

Read `rebuild-commits.md` in this folder (`${CLAUDE_PLUGIN_ROOT}/skills/rebuild-commits/`) in
full and follow its steps in order. Also load `/workflow:commit-rules` if it isn't loaded: every
rebuilt commit must follow it. The project's values (main branch, checks, local review branch,
review script) are in the **This project** table of `.claude/how-we-work.md`.

If the project has no **This project** table, stop and ask the owner to add one (template:
`${CLAUDE_PLUGIN_ROOT}/templates/this-project.md`).

- This rewrites the branch's history, so it runs only when the owner asked for it.
- Step 1 is a plan table. Change nothing until the owner types "yes".
- Make the backup branch before the first reset; never overwrite or delete an existing one.
- Finish with the proof step (`git diff backup/<branch> HEAD`) and the hand-over, then suggest
  `/workflow:review-commits` for the review itself.
