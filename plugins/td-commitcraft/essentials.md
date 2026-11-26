# How we work (td-commitcraft)

Loaded at the start of every chat by the td-commitcraft plugin. These basics apply to every
project. The project's own rules and values follow below, from
`.claude/td-commitcraft/project.md`; where the project differs, the project wins. A file
`.claude/td-commitcraft/<skill>.md` adds the project's rules for that one skill. Last comes a
**This branch** block: the current branch, whether the tree is clean, its row in the branch plan,
and the rules for starting a branch or working on one.

## Plan first

- Read the project's reference material first.
- Before building, show a plan: structure, decisions, open questions. Ask whenever a structural
  decision could go either way, with a recommended answer. Wait for the owner's answer.
- Keep it simple.

## Ask first, every time

- **Any change.** Build only when the owner explicitly says so: agreeing that a change is needed
  is not a go-ahead. Before changing anything (files, database, commits), list exactly what will
  change and wait for "yes".
- **Any library.** Prefer built-ins; ask before adding one, with the reason.
- **Any new table.** Propose the schema for review; write the migration only after approval.
- **Any cloud build.** Build locally. Never start a cloud build or a deploy unless the owner asks
  for it and confirms.

## Git basics

- Work on one branch at a time, started from the work branch. If the owner is on another
  branch, change nothing: list the changes, ask them to switch, and wait.
- Never push unless asked. Never merge unless the owner says "approved, merge": "looks good" is
  not approval.
- Never amend, reorder, reset or rewrite existing commits. The owner may edit, squash or reset
  commits and code while reviewing: never undo or "repair" that, and don't rely on commit hashes
  quoted earlier.
- Never add Claude as a co-author.
- One chat per branch. If a chat gets long mid-branch, write a short handoff first.

## Explaining

- Easy-to-understand, professional language and complete sentences. Use real code from this
  repo, tables or simple examples where they help, tied to the current task.
- Add a short code-flow block when it helps show how pieces connect; don't repeat one already
  given in the same chat.
- For a walkthrough where several lines each matter, show the snippet with `// (a)`, `// (b)`
  markers on the key lines and explain each marker in a bullet below it. Only where needed.

## Honesty

- Verify before claiming something works; report failures with the actual output.
- Own mistakes plainly, fix them on the branch, and note them in the summary.
- Give short status updates during long work.
- When there is a better way, say so once, with the reason; then build the owner's choice.

## Suggest the right skill, so we don't forget

When the work reaches one of these points and the skill is not loaded in this chat, say so in one
line and suggest it. Do not work from memory of a skill that is not loaded. The project's own
skills are listed in its `project.md`.

| Point in the work                                                                                        | Skill                             |
| -------------------------------------------------------------------------------------------------------- | --------------------------------- |
| Starting a project, or moving one onto this plugin                                                       | `/td-commitcraft:init`            |
| Starting work on a branch or a feature from the plan ("work on feature #7")                              | `/td-commitcraft:start-branch`    |
| Planning a release or a branch, adding or closing a todo, a branch merged, cutting or shipping a release | `/td-commitcraft:plan-release`    |
| Before the first commit of a branch, when committing, and when finishing a branch                        | `/td-commitcraft:commit-rules`    |
| The owner reviews a branch ("explain", "next", "chk again", "review is done", the review script)         | `/td-commitcraft:review-commits`  |
| The owner asks to restructure, rebuild or recreate a branch's commits                                    | `/td-commitcraft:rebuild-commits` |
