# td-commitcraft

One versioned set of rules for how work happens in a project: plan a release in branches, plan
and make commits, rebuild a branch's history, and release from develop to main. The skills are
general: each one takes the project's own values from the **This project** table in the
project's `.claude/how-we-work.md`.

Install it for yourself:

```
/plugin install td-commitcraft --marketplace Todomist/td_claude_plugins
```

For a whole project, and to pin a version: the repository's [README](../../README.md).

| Skill                             | When to use                                                                                |
| --------------------------------- | ------------------------------------------------------------------------------------------ |
| `/td-commitcraft:plan-release`    | Planning a release or a branch, adding a todo, after a branch is merged, cutting a release |
| `/td-commitcraft:commit-rules`    | Before the first commit of a branch, when committing, and when finishing a branch          |
| `/td-commitcraft:rebuild-commits` | Rebuilding a branch's commits into a clean sequence. Only on request: it rewrites history  |

A fourth skill, `review-commits` (a commit-by-commit review with its script), comes back in a
later version.

The usual order in the life of a branch:

1. Planning the release or the branch → `plan-release`; its commits → `commit-rules`
2. Building → the project's own code rules
3. Finishing the branch → `commit-rules` (end-of-branch steps)
4. History messy → `rebuild-commits` (only on request)
5. Reviewing → the owner, commit by commit, with the project's review script
6. After the merge → `plan-release` (status, plan row, todos; a release when it is time)

## The contract: the "This project" table

Every row must be in the project's table; write `none` when it does not apply yet. If the table
is missing, the skills stop and ask for it. Template to copy:
[templates/this-project.md](templates/this-project.md).

| Row                    | Read by                                         | What it holds                                                     |
| ---------------------- | ----------------------------------------------- | ----------------------------------------------------------------- |
| Work branch            | all                                             | The branch every branch starts from and merges back into          |
| Branch names           | plan-release, commit-rules                      | How branches are named                                            |
| Checks                 | commit-rules, rebuild-commits                   | The command that runs lint, format, typecheck and tests           |
| Run it                 | plan-release, commit-rules                      | How to start the app and try it end to end                        |
| Docs                   | commit-rules                                    | Where the docs on how the app works live                          |
| Status                 | plan-release                                    | The short "where we are" file                                     |
| Branch plan            | plan-release                                    | The file with the release's numbered branches                     |
| Todos                  | plan-release                                    | The file with every item left for later                           |
| Release branch         | plan-release                                    | The branch with released versions only, its tags, the notes       |
| Extra planning rules   | plan-release                                    | A project file with more planning rules                           |
| Review script          | commit-rules, rebuild-commits                   | A script in the project, e.g. `.claude/scripts/review-commits.sh` |
| Local review branch    | commit-rules, rebuild-commits                   | The owner's local copy of a branch for reviewing                  |
| Debug log prefix       | commit-rules                                    | The prefix of temporary debug logs                                |
| Production             | review-commits (later)                          | What runs in production (read only during a review)               |
| Paid services          | commit-rules                                    | Services that cost money per call, and their fakes                |
| Examples for the owner | review-commits (later)                          | Real things from the product that explanations start from         |

Project-only skills (for example a project's code rules) stay in the project, beside these.

## What it runs

Nothing on its own: no hooks, no MCP servers, no scripts, no network access, and it stores no
data. The skills are instructions for Claude, and `templates/this-project.md` is the table
template. Privacy: [PRIVACY.md](PRIVACY.md).

## Versions

`MAJOR.MINOR.PATCH`, in `.claude-plugin/plugin.json`; what changed is in
[CHANGELOG.md](CHANGELOG.md).

- **Patch** (0.1.0 → 0.1.1): changes or fixes to existing skills, rules or wording.
- **Minor** (0.1 → 0.2): a new skill or a new part of the plugin, such as a hook.
- **Major** (→ 1.0.0): a big rework of how the plugin works.

Changes collect under **Unreleased** in the CHANGELOG. The version is raised, tagged and
released only after the owner's explicit "yes".
