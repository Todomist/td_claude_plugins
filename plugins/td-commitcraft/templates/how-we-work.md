# How we work on <project>

Copy this file to the project's `.claude/how-we-work.md`, load it in every chat from `CLAUDE.md`
(`@.claude/how-we-work.md`), and fill in the **This project** table. The td-commitcraft skills
rely on these basics and never repeat them: each rule lives here and nowhere else. The detailed
rules are skills, loaded when the work reaches them (table at the end).

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

- Work on one branch at a time. If the owner is on another branch, change nothing: list the
  changes, ask them to switch, and wait.
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

## Project rules

Rules only this project has (reference material, approved libraries, what never to touch).
Delete this section if there are none.

## This project

The `/td-commitcraft:…` skills take this project's values from this table. Write `none` for a row
that does not apply yet. What each row is for: the plugin's `README.md`.

| What                   | Value                                                                      |
| ---------------------- | -------------------------------------------------------------------------- |
| Work branch            | `develop`: every branch starts from it and merges back into it             |
| Branch names           | `feature/<name>`, `fix/<name>`, `chore/<name>`                             |
| Checks                 | `npm run check` from the repository root (lint, format, typecheck, tests)  |
| Run it                 | How to start the app and try it end to end                                 |
| Docs                   | `.claude/docs/` (how the app works; index in its `README.md`)              |
| Status                 | e.g. `.claude/releases/status.md` (short: a new chat reads it first)       |
| Branch plan            | e.g. `.claude/releases/plan.md` (the release in progress, then drafts)     |
| Todos                  | e.g. `.claude/releases/todo.md` (one table, open and done)                 |
| Releases folder        | e.g. `.claude/releases/`: a `<version>/` folder per release that went out  |
| Release branch         | e.g. `release/<version>-<description>`, cut from `develop`; merged into `main` and `develop` once it is out, or `none` |
| Extra planning rules   | A project file with planning rules on top of the plugin's, or `none`       |
| Review script          | `bundled` (the plugin's), or a path in this project                        |
| Local review branch    | `<your-name>_local/<branch>` (local only, never pushed or merged)          |
| Debug log prefix       | e.g. `vjconsole_<area>`                                                    |
| Production             | What runs in production (database, hosting), or `none`                     |
| Paid services          | Services that cost money per call, and their fakes, or `none`              |
| Examples for the owner | 2 or 3 real things from the product to explain with                        |

## Suggest the right skill, so we don't forget

When the work reaches one of these points and the skill is not loaded in this chat, say so in one
line and suggest it. Do not work from memory of a skill that is not loaded. Add a row for each of
the project's own skills.

| Point in the work                                                                                        | Skill                             |
| -------------------------------------------------------------------------------------------------------- | --------------------------------- |
| Planning a release or a branch, adding or closing a todo, a branch merged, cutting or shipping a release | `/td-commitcraft:plan-release`    |
| Before the first commit of a branch, when committing, and when finishing a branch                        | `/td-commitcraft:commit-rules`    |
| The owner reviews a branch ("explain", "next", "chk again", "review is done", the review script)         | `/td-commitcraft:review-commits`  |
| The owner asks to restructure, rebuild or recreate a branch's commits                                    | `/td-commitcraft:rebuild-commits` |
