# td-workflow

How we work in a project: plan a release in branches, plan and make commits, review a branch
commit by commit, rebuild a branch's commits, and cut a release. The skills are general: each
one takes the project's own values from the **This project** table in the project's
`.claude/how-we-work.md`. How a project installs it and pins a version: the repository's
[README](../../README.md).

| Skill                       | When to use                                                                                       |
| --------------------------- | ------------------------------------------------------------------------------------------------- |
| `/td-workflow:plan-release`    | Planning a release or a branch, adding a todo, after a branch is merged, cutting a release         |
| `/td-workflow:commit-rules`    | Before the first commit of a branch, when committing, and when finishing a branch                 |
| `/td-workflow:review-commits`  | Reviewing a branch commit by commit: "explain", "next", "chk again", "review is done"              |
| `/td-workflow:rebuild-commits` | Rebuilding a branch's commits into a clean sequence. Only on request: it rewrites history         |

The usual order in the life of a branch:

1. Planning the release or the branch → `plan-release`; its commits → `commit-rules`
2. Building → the project's own code rules
3. Finishing the branch → `commit-rules` (end-of-branch steps)
4. History messy → `rebuild-commits` (only on request)
5. Reviewing → `review-commits`
6. After the merge → `plan-release` (status, plan row, todos; a release when it is time)

## The contract: the "This project" table

Every row must be in the project's table; write `none` when it does not apply yet. If the table
is missing, the skills stop and ask for it. Template to copy:
[templates/this-project.md](templates/this-project.md).

| Row                    | Read by                                         | What it holds                                                     |
| ---------------------- | ----------------------------------------------- | ----------------------------------------------------------------- |
| Main branch            | all                                             | The branch every branch starts from and merges into              |
| Branch names           | plan-release, commit-rules                      | How branches are named                                            |
| Checks                 | commit-rules, rebuild-commits                   | The command that runs lint, format, typecheck and tests           |
| Run it                 | plan-release, commit-rules                      | How to start the app and try it end to end                        |
| Docs                   | commit-rules                                    | Where the docs on how the app works live                          |
| Status                 | plan-release                                    | The short "where we are" file                                     |
| Branch plan            | plan-release                                    | The file with the release's numbered branches                     |
| Todos                  | plan-release, review-commits                    | The file with every item left for later                           |
| Releases               | plan-release                                    | The release branch name and where release notes live              |
| Extra planning rules   | plan-release                                    | A project file with more planning rules                           |
| Review script          | commit-rules, review-commits, rebuild-commits   | `bundled`, or a path in the project                               |
| Local review branch    | commit-rules, rebuild-commits                   | The owner's local copy of a branch for reviewing                  |
| Debug log prefix       | commit-rules                                    | The prefix of temporary debug logs                                |
| Production             | review-commits                                  | What runs in production (read only during a review)               |
| Paid services          | commit-rules, review-commits                    | Services that cost money per call, and their fakes                |
| Examples for the owner | review-commits                                  | Real things from the product that explanations start from         |

Project-only skills (for example a project's code rules) stay in the project, beside these.

## Bundled files

- `skills/review-commits/review-commits.sh`: the review script. The owner runs it in a terminal;
  `/td-workflow:review-commits` gives the full command, because the installed path changes with
  each version.
- `templates/this-project.md`: the table template.

## Versions

The version is in `.claude-plugin/plugin.json`; what changed is in [CHANGELOG.md](CHANGELOG.md).
While it is `0.x` the rules are still settling:

- **Minor** (0.1 → 0.2): any change to what the skills do, including a renamed or removed skill
  or a changed table row.
- **Patch** (0.1.0 → 0.1.1): wording fixes.
- **1.0.0** once the rules are settled. From then on: major when projects must change something,
  minor for a new skill or rule, patch for wording.
