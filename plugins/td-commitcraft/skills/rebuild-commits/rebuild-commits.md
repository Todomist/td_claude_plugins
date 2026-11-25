# Rebuilding commits for review

Only when the owner asks. A big branch grows as work commits; before the commit-by-commit review
it can be rebuilt into a clean sequence. During a review nothing is rewritten: changes go on top
as new commits (code first, then docs). Every rebuilt commit follows `/td-commitcraft:commit-rules`.
"The work branch" (`<work>` below), "the checks" and "the review script" mean the values in the
**This project** table of `.claude/how-we-work.md`.

## The life of a branch

A new branch follows this layout from its first commit: tests with the code, one docs commit,
`TEMP` last. Each review round adds commits on top and rewrites nothing, so after a round or two
the history no longer reads as one clean sequence (a "fix" for the bill sits far from the commit
that built it). When the owner wants the review to start again, the branch is rebuilt with the
steps below: every review commit is **folded into the commit it belongs to**, and changes to the
working rules become the **first commit**, so they are on disk during the whole review.

**The aim is the best review, not a number of commits or minutes.** Each commit holds **one
piece of functionality** that can be tested fully and understood easily; its size follows from
that. Too many small commits make the review hard; so do commits that mix two things.

## The order: core first, then one complete feature each

| Order | Commit holds                                                                                         | Example                                                        |
| ----- | ---------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| 1     | The working rules, if the branch changes them (`CLAUDE.md`, how-we-work, skills, the doc index)      | `docs: review rules, commits core first then one feature each` |
| 2     | A core piece the features stand on, one at a time, with its tests                                    | `feat(server): POST /v1/sync, the door for the app's changes`  |
| 3     | **One feature or API, complete:** its shared contract, server, screens, the old route it replaces, tests | `feat: a new order goes through the door`                  |
| 4     | ONE docs commit for everything the branch built                                                      | `docs: how offline mode works`                                 |
| last  | `TEMP: add <log prefix> debug logs` (dropped at merge)                                               | `TEMP: add vjconsole_sync debug logs`                          |

So the owner reads the cores once, then each feature's requests, responses, screens and tests in
one place, and can try it. Never "all the server, then all the app".

- **The app works after every commit.** A commit never removes a route, column or function that
  the code at that commit still uses. Check it by listing what every client (app, web app,
  worker) calls against what the server and database have, at every commit. A feature a client
  cannot show yet is hidden for that commit (a one-line guard) and the commit says so.
- Each commit has **its tests in the same commit** (no tests commit at the end). No `fix:` or
  `test:` commits that patch an earlier one; a version bump folds into the last feature commit.
- The subject names everything the commit holds; body 3 lines at most; no Claude co-author.
- Every commit passes the checks on its own: no red typecheck "for the next commit".
- Why this order: a branch once rebuilt layer by layer (server, then app) had server commits
  that removed routes the app still called, so ten commits could not be tried in the app and had
  no tests.

## The steps

The branch keeps its name; the backup is the only extra branch.

1. **Plan.** Read `git log <work>..<branch>` and `git diff --stat <work>...<branch>`, group the
   files into commits (folding each review commit into the one it belongs to), and show a table
   (number, subject, what is in it, what the owner can try). Change nothing until the owner
   types "yes".
2. **Backup.** `git branch backup/<branch> <branch>` (the same name with the prefix, e.g.
   `backup/feature/offline-mode`). If it already exists, ask; never overwrite or delete it.
3. **Rebuild on the branch itself** (clean working tree): `git reset --hard <work>`, then for
   each commit bring in only its files with `git checkout backup/<branch> -- <files>`, edit out
   what belongs to later commits, `git add`, run the checks, commit.
4. **In batches, when the owner asks.** Build a few commits, stop, and wait for the review. What
   the owner asks to change is folded into the commit it belongs to (the rebuild is in
   progress); the next batch starts when they say so, carved from the backup
   (`git show backup/<branch>:<path>`).
5. **Prove.** When the last batch is done, `git diff backup/<branch> HEAD` prints nothing, or
   only what was added or changed on purpose (list each). If anything else shows, a file was
   lost or changed: fix it before going on.
6. **Hand over.** List the new commits, say the hashes changed, and remind the owner to recreate
   the local review branch and run the review script (base: the work branch). Then suggest
   `/td-commitcraft:review-commits`.

If the rebuild goes wrong or stops half way, `git reset --hard backup/<branch>` puts the branch
back exactly as it was.

## Pitfalls

- `git checkout <ref> -- file` **stages** the file: edit it first, then `git add`, or a later
  commit's change leaks into an early one.
- A file with changes for several commits (e.g. `orders.ts`): write the in-between content by
  hand for each commit; step 5 proves the last one adds up.
- In zsh `$B:path` is a path modifier: write `"${B}:path"`.
- The owner edited code or the todos meanwhile: read the current files first, never "repair".
