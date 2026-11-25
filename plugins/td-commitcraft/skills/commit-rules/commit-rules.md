# Commit rules

How commits are planned, sized, ordered and named, and what happens at the end of a branch. The
basics (one branch at a time, never push or merge unasked, never rewrite commits, no co-author)
are in `.claude/how-we-work.md` and are not repeated here. Words like "the work branch", "the
checks" or "the review script" mean the values in its **This project** table.

## Branches

- Created from the work branch and named as the table's **Branch names** row says (e.g.
  `feature/<name>`, `fix/<name>`, `chore/<name>`).
- How a release is split into branches and how big a branch is: `/td-commitcraft:plan-release`.

## Commits

- Before the first commit of a project: `.gitignore` files. Never commit secrets (`.env`); do
  commit lockfiles and `.env.example` files.
- **Plan them first.** Before the first commit of a branch, work out how many commits it needs
  and what each holds, tell the owner the plan, and stick to it. A small branch can be 2 or 3
  commits.
- **Size: medium.** Each commit holds one clear piece of work the owner can review in about 20
  to 30 minutes. Not less: a version bump, a typo or one test file on its own floods the
  history, so fold it into the commit it belongs to. Not more: split what takes longer.
- **Order:** core pieces first, then one complete feature per commit (its shared contract,
  server, screens, the old route it replaces, and its tests), in the order they build on each
  other. Never "all the server, then all the app".
- **The app works after every commit:** no commit removes a route, column or function that the
  code at that commit still uses.
- **Tests go in the same commit** as the code they test, written while building that piece, not
  in a tests commit at the end. Each commit passes the checks on its own.
- **Subject:** a short, to-the-point conventional subject (`feat:`, `fix:`, `docs:`…) that names
  everything the commit holds; code is never titled `docs:`. **Body:** 3 lines at most, no long
  descriptions.
- **Debug logs are temporary:** they go in one last commit titled
  `TEMP: add <log prefix> debug logs` (e.g. `TEMP: add vjconsole_sync debug logs`), so the owner
  can drop it before merge. What a log may contain: the project's code rules.
- **Changes asked for during review** go on the same branch as new commits on top (code first,
  then docs), bundled into one medium commit per topic, not one commit per tweak. Read the
  current code first (the owner may have edited or squashed commits, and hashes quoted earlier
  may be gone), make the change, and update the docs to match.

## End of every branch

1. Run every check (lint, format, typecheck, tests) and actually run the app end to end (the
   **Run it** row). Where the project has **Paid services**, use their fakes unless the owner
   approved a paid run.
2. Check the commit layout: core pieces first, then one complete feature per commit with its
   tests; then ONE docs commit that updates the docs (how the application works); the `TEMP`
   logs commit last. If the history no longer reads that way, suggest `/td-commitcraft:rebuild-commits`.
   Docs: short files (under about 100 lines), grouped by topic, plain words, diagrams and
   examples. They live in the project's docs folder (the **Docs** row), committed and never
   git-ignored; only `README.md` (setup) and `CLAUDE.md` stay at the root.
3. Stop and show the owner: what was built, the commits, how to try it, the folder tree, new
   dependencies, what any paid run cost, and anything that didn't work or needs their attention.
4. Remind the owner to review commit by commit: suggest creating the local review branch from
   the branch (the **Local review branch** row: local only, never pushed or merged), and give
   them the review script command to run themselves (base: the work branch). Then follow
   `/td-commitcraft:review-commits` as they move through the commits.
5. After "approved, merge": merge into the work branch with `--no-ff`. Then follow "After a
   branch is merged" in `/td-commitcraft:plan-release`.
