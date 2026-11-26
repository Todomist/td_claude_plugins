# Changelog

## 0.1.5

- A **This branch** block at the start of every chat (`hooks/session-start.sh`): the current
  branch and whether the tree is clean, then on the work branch the steps to start a branch, on
  any other branch its row in the branch plan and the commit basics (`branch-essentials.md`). A
  detached HEAD says a review may be running.
- A branch guard (`hooks/branch-guard.sh`): `git checkout -b` and `git switch -c` are blocked
  unless the current branch is a clean work branch.
- The start of every chat names the plugin and its version.
- `init` also reads Claude's notes for the project (its memory) and lists every rule or decision
  in them that the repository does not have yet, with where it should go.

## 0.1.4

- `start-branch` also reads the project's map (`.claude/td-codecraft/map.md`) when it exists, to
  see what a feature touches.

## 0.1.3

- New `init`: sets up a project, or moves one onto the plugin. It asks for the project's own
  rules and the This project values, writes `.claude/td-commitcraft/project.md` and the releases
  folder, and moves an older `.claude/how-we-work.md` across.
- New `start-branch`: "work on feature #7" reads the plan row, its todos, the status file and the
  project's stack, shows the scope, the open questions and the commit plan, and creates the
  branch after the owner's "yes".
- The basics (plan first, ask first, git basics, explaining, honesty, which skill when) load in
  every chat from the plugin: a `SessionStart` hook prints `essentials.md` and the project's
  `.claude/td-commitcraft/project.md`. The project's file holds only its own rules, the This
  project table and its own skills; `templates/project.md` replaces `templates/how-we-work.md`.
- A file `.claude/td-commitcraft/<skill>.md` adds the project's rules for one skill; the project
  wins where it differs. It replaces the **Extra planning rules** row.

## 0.1.2

- The basics the skills rely on now ship with the plugin: `templates/how-we-work.md` (plan first,
  ask first, git basics, explaining, honesty, the This project table, which skill when) replaces
  `templates/this-project.md`. Every skill stops and asks for `.claude/how-we-work.md` and its
  table when either is missing.
- `commit-rules`: check the branch with `git branch --show-current` right before every commit
  and merge, and stop if it is not the branch being worked on; commit only after the checks
  pass; merge with `git merge --no-ff -F <file>`.

## 0.1.1

- Versions: every push raises the version and gets a tag, `td-commitcraft-v<version>`, which
  never moves. Projects pin `ref` to that tag.
- `plan-release`: **When** on a todo is the release (`0.2`), not the version (`0.2.17`); finishing
  touches sets it to this release on each row it still needs.
- `plan-release`: after a branch is merged, Claude also updates its notes (memory) with where we
  are.
- `plan-release` is the version finalised in our projects: the status, the branch plan (Now and
  Next) and the todos sit at the top of the releases folder; the todos are one table with a Done
  date; finishing touches picks what the release still needs; a release branch is cut from the
  work branch, built and deployed, then merged into the branches the **Release branch** row
  names; each shipped release gets its own version folder. New table row **Releases folder**;
  the **Release branch** row now names the branch and where it merges.
- `review-commits` is back, with its script `review-commits.sh`, which the owner runs in a
  terminal. It may read `.env` files and logs during a review. The **Review script** row can say
  `bundled` again.
- README: install from a version tag (`/plugin marketplace add
  Todomist/td_claude_plugins#td-commitcraft-v0.1.1`).

## 0.1.0

- First version: `plan-release`, `commit-rules` and `rebuild-commits`. Each skill is one wording,
  merged from the copies our projects kept in `.claude/skills/`. `plan-release` is new: planning
  a release in branches, the branch plan, the todos, the status file, releases and versions.
- Work branch and release branch: work happens on the work branch (`develop`); the release
  branch (`main`) holds released versions only. A release merges the work branch into the
  release branch with `--no-ff` and tags it, only after the owner's "yes".
- Project values come from the **This project** table; template in `templates/this-project.md`.
- Listing details in `plugin.json` (display name, keywords, links) and a privacy note in
  `PRIVACY.md`: the plugin collects, stores and sends no data.
- `review-commits` and its script come in a later version: the Claude directory accepts scripts
  only from verified organizations. Until then the **Review script** row names a script in the
  project.
