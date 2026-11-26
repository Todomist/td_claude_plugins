# td-commitcraft

One versioned set of rules for how work happens in a project: plan a release in branches, plan
and make commits, review a branch commit by commit, rebuild its history, and release from
develop to main. The basics (plan first, ask first, git basics, explaining, honesty) load in
every chat; the skills are general and take the project's own values from its
`.claude/td-commitcraft/project.md`.

Install it for yourself:

```
/plugin marketplace add Todomist/td_claude_plugins#td-commitcraft-v0.1.2
/plugin install td-commitcraft@todomist
```

For a whole project, and to pin a version: the repository's [README](../../README.md).

| Skill                             | When to use                                                                                |
| --------------------------------- | ------------------------------------------------------------------------------------------ |
| `/td-commitcraft:init`            | Starting a project, or moving one onto the plugin: writes `.claude/td-commitcraft/project.md` |
| `/td-commitcraft:start-branch`    | Starting work on a branch from the plan: "work on feature #7"                              |
| `/td-commitcraft:plan-release`    | Planning a release or a branch, adding a todo, after a branch is merged, cutting a release |
| `/td-commitcraft:commit-rules`    | Before the first commit of a branch, when committing, and when finishing a branch          |
| `/td-commitcraft:review-commits`  | Reviewing a branch commit by commit: "explain", "next", "chk again", "review is done"      |
| `/td-commitcraft:rebuild-commits` | Rebuilding a branch's commits into a clean sequence. Only on request: it rewrites history  |

The usual order in the life of a branch:

1. Once per project → `init`. Planning the release → `plan-release`; starting a branch from the
   plan → `start-branch`; its commits → `commit-rules`
2. Building → the project's own code rules
3. Finishing the branch → `commit-rules` (end-of-branch steps)
4. History messy → `rebuild-commits` (only on request)
5. Reviewing → `review-commits`
6. After the merge → `plan-release` (status, plan row, todos; a release when it is time)

## The contract: `.claude/td-commitcraft/`

At the start of every chat the plugin loads its basics ([essentials.md](essentials.md)) and the
project's `.claude/td-commitcraft/project.md` ([template](templates/project.md)): the project's
own rules, the **This project** table below, and the project's own skills. Where the project
differs from the basics, the project wins. A file `.claude/td-commitcraft/<skill>.md` adds the
project's rules for one skill (e.g. `plan-release.md`: "build only the current rung"). Every row
must be in the table; write `none` when it does not apply yet. If `project.md` or its table is
missing, the skills stop and suggest `/td-commitcraft:init`.

| Row                    | Read by                                         | What it holds                                                     |
| ---------------------- | ----------------------------------------------- | ----------------------------------------------------------------- |
| Work branch            | all                                             | The branch every branch starts from and merges back into          |
| Branch names           | plan-release, commit-rules                      | How branches are named                                            |
| Checks                 | commit-rules, rebuild-commits                   | The command that runs lint, format, typecheck and tests           |
| Run it                 | plan-release, commit-rules                      | How to start the app and try it end to end                        |
| Docs                   | commit-rules                                    | Where the docs on how the app works live                          |
| Status                 | plan-release                                    | The short "where we are" file                                     |
| Branch plan            | plan-release                                    | The file with the release's numbered branches                     |
| Todos                  | plan-release, review-commits                    | The file with every todo, open and done, in one table             |
| Releases folder        | plan-release                                    | Where the status, plan and todos sit, and a folder per release    |
| Release branch         | plan-release                                    | Its name, and the branches it merges into once the release is out |
| Review script          | commit-rules, review-commits, rebuild-commits   | `bundled`, or a path in the project                               |
| Local review branch    | commit-rules, rebuild-commits                   | The owner's local copy of a branch for reviewing                  |
| Debug log prefix       | commit-rules                                    | The prefix of temporary debug logs                                |
| Production             | review-commits                                  | What runs in production (read only during a review)               |
| Paid services          | commit-rules, review-commits                    | Services that cost money per call, and their fakes                |
| Examples for the owner | review-commits                                  | Real things from the product that explanations start from         |

A project's own skills stay in the project; `project.md` lists them so they are suggested too.

## What it runs

No MCP servers, no network access, and it stores no data. The skills are instructions for
Claude. Privacy: [PRIVACY.md](PRIVACY.md).

- A `SessionStart` hook (`hooks/hooks.json`) prints `essentials.md` and the project's
  `.claude/td-commitcraft/project.md` at the start of every chat, with `cat`. It reads nothing
  else and writes nothing.

- `skills/review-commits/review-commits.sh` runs only when the owner starts it in a terminal
  (`/td-commitcraft:review-commits` gives the full command, because the installed path changes
  with each version). It uses git on the current repository only: it refuses to start with
  uncommitted changes, checks out the branch's commits one at a time, discards edits made while
  reviewing when it moves on, and returns to the branch at the end. It never pushes.
- `templates/project.md` is the template for the project's `.claude/td-commitcraft/project.md`.

## Versions

`MAJOR.MINOR.PATCH`, in `.claude-plugin/plugin.json`; what changed is in
[CHANGELOG.md](CHANGELOG.md).

- **Patch** (0.1.0 → 0.1.1): changes or fixes to existing skills, rules or wording.
- **Minor** (0.1 → 0.2): a new skill or a new part of the plugin, such as a hook.
- **Major** (→ 1.0.0): a big rework of how the plugin works.

Changes collect under **Unreleased** in the CHANGELOG. Each push turns them into a new version
with a tag, `td-commitcraft-v<version>`, which never moves; projects pin `ref` to it. Nothing is
pushed or tagged without the owner's explicit "yes".
