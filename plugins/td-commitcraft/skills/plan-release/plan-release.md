# Planning and releases

How a release is planned in numbered branches and how each branch is sized; how the branch plan,
the todos and the status file are kept; and how a release is cut, shipped, versioned and filed in
its own folder. Commits inside a branch: `/td-commitcraft:commit-rules`. "The work branch", "the status file",
"the branch plan", "the todos", "the releases folder" and "the release branch" mean the values in
the **This project** table of `.claude/how-we-work.md`. If its **Extra planning rules** row names a
file, those rules come on top of these.

## Ask first

- Show the plan in the chat first. Change the branch plan, the todos or the status file only
  after the owner's "yes".
- Cutting a release branch, merging, pushing, deploying and releasing on a store each happen only
  when the owner asks for that step. Never start a cloud build unless the owner asks for it.

## Where things live

The current work sits at the top of the releases folder. A folder per release appears only once
that release has gone out:

```
<releases folder>/
├── status.md     where we are (loads in every chat: keep it short)
├── plan.md       the branch plan: the release in progress, then drafts
├── todo.md       every todo, open and done, in one table
├── …             reference files for the whole product (features, competitors, ideas)
├── 0.1.0/        a release that went out: its plan and notes
└── 0.2.15/
```

- A version folder is made **when its release goes out**, never before, so there are no folders
  for releases that are only planned. It is named after the version that shipped.
- Until then, everything for the release in progress stays at the top.

## Planning branches

- Plan each release in about 15 numbered branches (13–17 is healthy; never more than 20), each
  one end-to-end functionality.
- Size every branch with two tests: the owner can try it end to end (as the **Run it** row says),
  and can review it (code, docs, tables) in one sitting, about an hour. Split a branch only when
  it fails that test; join two tiny neighbours.
- Build shared UI in layers: an early UI-kit branch with only the core pieces every screen uses;
  feature-specific components go in the branch that first needs them.
- Flag heavy branches early, especially ones that depend on outside approvals or setup (payment,
  messaging, store accounts), and plan where to split them if they grow.
- The last branch of every release is `chore/finishing-touches` (below).

## The branch plan

Two parts:

- **Now:** the release in progress, one table of its numbered branches.
- **Next:** drafts for later releases, one table each. A draft becomes the Now table when we plan
  that release; its branch numbers are set then.

| #   | Branch                    | IDs     | What it delivers               | Status      |
| --- | ------------------------- | ------- | ------------------------------ | ----------- |
| 1   | `feature/<name>`          | B9      | One end-to-end piece, in words | Not started |
| 15  | `chore/finishing-touches` | T2, N13 | The last branch (below)        | Not started |

- **IDs** are the todo rows the branch builds; blank when there are none.
- **Status:** `Not started`, `In progress` or `Merged`, with a short note when it helps.

## The todos

Every item we agree to leave for later gets a row, in **one table** sorted by ID. A row stays
after it is closed, with the date, so the file shows progress by month and by release.

| ID  | Todo                     | Details | Suggested                 | When   | Priority | Done        | Notes |
| --- | ------------------------ | ------- | ------------------------- | ------ | -------- | ----------- | ----- |
| N13 | Settings refresh on pull | …       | `chore/finishing-touches` | 0.2.17 | P1       |             |       |
| T1  | Release docs layout      | …       | `chore/finishing-touches` | 0.2.17 | P1       | 26 Nov 2026 |       |

- **ID:** a letter for the topic and a number; a key of the letters sits above the table. It
  never changes, so a row can be named in a chat, a commit or the branch plan. A new row takes
  the next free number of its topic.
- One row per piece of work, not per detail, in enough words to make sense months later: what it
  is, why it matters, what it needs.
- **Suggested** is Claude's pick (a planned branch, or a branch of its own), only a starting
  point.
- **When:** the release it is planned for (`0.3`), `Later`, or `Drop` (not doing it; the note
  says why). Blank: not planned yet.
- **Priority:** P1 must have: the release waits for it, and it gets a branch in the plan. P2
  should have: soon, but nothing waits on it; it goes into the branch whose code it touches, or
  into finishing touches. P3 nice to have.
- **Done:** the date the row was closed (built, decided or dropped), written `26 Nov 2026`; only
  the month (`Nov 2026`) when that is all the record shows. Blank means open. Never guess a date:
  take it from the commit or the doc that records it.
- **When**, **Priority** and **Notes** are the owner's.
- When we decide during a branch that something waits, it gets a row, or is added to the row it
  belongs to.

## The status file

Short on purpose: it loads at the start of every chat. Where we are (the current branch, what is
merged, what is next) and what waits on outside setup. It is not a history: what shipped goes in
the version folder, and what is done shows in the todos.

## After a branch is merged

Update the status file, the branch's row in the branch plan (`Merged`) and the todos: each row
the branch built gets its Done date, and new "later" rows are added. The owner starts a new chat
for the next branch.

## Finishing touches: the last branch of every release

`chore/finishing-touches` builds nothing new. It goes through the todos, sets **When** to this
release's version on each row the release still needs and moves the rest to a later release;
then it cleans up code and docs, keeps the test docs current, tests everything by hand and fixes
the bugs it finds. Its row in the branch plan lists the IDs it picked.

## Shipping a release

Each step only when the owner asks for it.

1. **Cut** the release branch from the work branch once the last branch is merged, named as the
   **Release branch** row says. Nothing new is built on it.
2. **Build and deploy from the release branch only.** A fix found now is made on the release
   branch and takes the next free patch (Versions, below).
3. **Once it is out** (on the stores, the server live): merge the release branch into the
   branches the **Release branch** row names, with `--no-ff`. The fixes made on it reach the work
   branch this way.
4. **File it:** make the version folder, named after the version that shipped, and move in:
   - the release's branch plan (its Now table) as `plan.md`;
   - `notes.md`: what shipped, the release branch, where it is live (stores, server), what is
     next;
   - any file written only for this release (store text, a deploy checklist).
5. **Move on:** the next release's draft becomes the Now table, and the status file says where we
   are.

## Versions

MAJOR.MINOR.PATCH. The minor goes up once per release; the patch is the plan number of the last
branch merged into the work branch (#14 → 0.2.14), set in that branch's last app commit. A fix
made on the release branch after it is cut takes the next free patch.
