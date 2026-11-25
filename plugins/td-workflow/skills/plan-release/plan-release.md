# Planning and releases

How a release is planned in branches, how a branch is sized, how the branch plan, the todos and
the status file are kept, and how releases and versions work. Commits inside a branch:
`/td-workflow:commit-rules`. Words like "the main branch", "the branch plan", "the todos" or "the
status file" mean the values in the **This project** table of `.claude/how-we-work.md`. A row
that says `none` means that part does not apply to this project yet.

## Planning branches

- Plan each release in about 15 numbered branches (13–17 is healthy; never more than 20), each
  one end-to-end functionality. A project that plans in phases instead of releases treats each
  phase as a release.
- Size every branch with two tests: the owner can try it end to end (as the **Run it** row says:
  on the device, in the browser, or from the command line), and can review it (code, docs,
  tables) in one sitting, about an hour. Split a branch only when it fails that test; join two
  tiny neighbours.
- Build shared UI in layers: an early UI-kit branch with only the core pieces every screen uses;
  feature-specific components go in the branch that first needs them.
- Flag heavy branches early, especially ones that depend on an account, approval or payment
  outside the code (payments, messaging, store or provider accounts). Mark them **outside
  setup** in the plan, start that setup early so the branch is not left waiting, and plan where
  to split them if they grow.
- A branch builds only its own row of the plan: nothing for a later branch is added early.

## The branch plan

One table per release (or phase) in the branch plan file:

| #   | Branch                    | IDs | What it delivers                | How to try it                  | Status      |
| --- | ------------------------- | --- | ------------------------------- | ------------------------------ | ----------- |
| 1   | `feature/<name>`          | B9  | One end-to-end piece, in words  | What the owner does to try it  | Not started |
| 15  | `chore/finishing-touches` |     | The last branch (see Releases)  | Everything, by hand            | Not started |

- **IDs** are the todo rows the branch builds; blank when there are none.
- Todos that are add-ons or fixes, not core building, go into the branch whose code they touch,
  or into finishing touches. None gets a branch of its own.
- **Status:** `Not started`, `In progress` or `Merged`, with a short note when it helps.

## The todos

Every item we agree to leave for later gets a row in the todos file, one table per topic:

| ID  | Todo | Details | Suggested | When | Priority | Notes |
| --- | ---- | ------- | --------- | ---- | -------- | ----- |

- **ID:** a letter for the topic and a number. It never changes, so a row can be named in a chat
  or a commit, and it keeps its ID when it moves into a branch plan.
- One row per piece of work, not per detail, in enough words to make sense months later: what
  it is, why it matters, what it needs.
- **Suggested** is Claude's pick (a planned branch, or a branch of its own), only a starting
  point. **When** is the release or phase it is planned for, `Later`, `Done` or `Drop`.
  **Priority:** P1 needed before other people use it, P2 wanted soon, P3 nice to have. **When**,
  **Priority** and **Notes** are the owner's.
- When we decide during a branch that something waits, it gets a row, or is added to the row it
  belongs to. A row leaves the todos when it is built, or moves into a branch plan with the same
  ID.

## The status file

Short on purpose: a new chat reads it first. Where we are (the current branch, what is merged,
what is next) and what waits on outside setup. It is not a history.

## After a branch is merged

Update the status file, the branch's row in the branch plan, the todos (rows built leave, new
"later" rows are added) and your notes with where we are. The owner starts a new chat for the
next branch. If a chat gets long mid-branch, write a short handoff first.

## Releases

Skip this section while the **Releases** row says `none`.

- The app ships in releases, each with its own plan of numbered branches, all merged into the
  main branch. The last branch of every release is `chore/finishing-touches`.
- `chore/finishing-touches` builds nothing new: it goes through the todos, picks what this
  release still needs and marks the rest for a later release; then it cleans up code and docs,
  keeps the test docs current, tests everything by hand and fixes the bugs it finds.
- When the main branch is ready, cut the release branch from it, named as the **Releases** row
  says (e.g. `release/<version>-<description>`). Builds and deploys come from the release
  branch, and only when the owner asks.
- Versions are MAJOR.MINOR.PATCH: the minor goes up once per release; the patch is the plan
  number of the last branch merged into the main branch (#14 → 0.2.14), set in that branch's
  last app commit. A fix made on a release branch after it is cut takes the next free patch.
- Each release keeps its own notes (features, store status, what is next) where the
  **Releases** row says.
