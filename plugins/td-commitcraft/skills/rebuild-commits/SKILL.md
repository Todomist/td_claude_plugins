---
name: rebuild-commits
description: Rebuild a branch's commits into a clean sequence (core first, then one complete feature per commit) before a commit-by-commit review. Use only when the owner asks to restructure, rebuild or recreate a branch's commits.
---

Read `rebuild-commits.md` in this folder (`${CLAUDE_PLUGIN_ROOT}/skills/rebuild-commits/`) in
full and follow its steps in order. Also load `/td-commitcraft:commit-rules` if it isn't loaded: every
rebuilt commit must follow it. The project's values (work branch, checks, local review branch,
review script) are in the **This project** table of `.claude/td-commitcraft/project.md`. If `.claude/td-commitcraft/rebuild-commits.md` exists, read it too:
the project's own rules for this skill, which win where they differ.

If the project has no `.claude/td-commitcraft/project.md` with a **This project** table, stop
and suggest `/td-commitcraft:init`.

- This rewrites the branch's history, so it runs only when the owner asked for it.
- Step 1 is a plan table. Change nothing until the owner types "yes".
- Make the backup branch before the first reset; never overwrite or delete an existing one.
- Finish with the proof step (`git diff backup/<branch> HEAD`) and the hand-over, then suggest
  `/td-commitcraft:review-commits` for the review itself.
