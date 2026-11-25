# Reviewing commits

How a commit-by-commit review chat works. Claude follows this whenever the owner reviews a branch
(says "explain", "next", "chk again", or runs the review script), without being told again. The
basics (git, "yes" before changes) are in `.claude/how-we-work.md`; "the work branch" (`<work>`
below), "the review script", "production", "the paid services" and "the examples" mean the
values in its **This project** table.

## 1. During the review: change nothing

- The owner runs the review script (base: the work branch): the repo is on a detached HEAD with
  one commit staged at a time.
- Change **nothing** (files, commits, database, memory) until the owner says the review is done
  and `git branch --show-current` shows the branch again.
- Production (database, file storage, hosting): read only. Give the SQL or the steps; the owner
  runs them.
- No paid service calls during a review: use the fakes or saved results.
- Mask secrets, keys, tokens, ids and phone numbers when reading `.env` or logs.

## 2. Find the staged commit, every time

On every "explain", "next" or "chk again": `git diff --cached --stat`, then match it with
`git diff --cached --quiet <sha>` over `git rev-list <work>..<branch>`. Start the answer with
`sha subject`. Never guess from earlier messages; skipped commits are fine.

## 3. Explain: small first, then in full

| The owner asks                | Claude gives                                        |
| ----------------------------- | --------------------------------------------------- |
| "explain"                     | 2 to 3 lines: what the commit does and why          |
| "in full", "how do I read it" | the four parts below                                |
| a comparison ("which fields", | ONE side-by-side table, a column per thing compared |
| "client vs server", "before") |                                                     |
| a short question              | a short answer                                      |

The four parts of a full explanation:

1. **Why it exists**, tied to the product (what its users do with it) and to this branch.
2. **Reading path**, step by step: step 1 file with line numbers, what to look at, what it hands
   to the next step; then step 2… ending with the tests. Follow the layers a request passes
   through, e.g. contract (shared types) → limits → schema (the gate) → service (the decisions)
   → repository (storage) → routes (side effects) → tests. For screens: tokens and theme →
   shared components → sections → pages → tests.
3. **Code flow**: a short block of which function calls which, and how the commit connects to
   the previous and next commits. Not repeated if already given in the chat.
4. **Tricky blocks only**: real code with `// (a)`, `// (b)` markers, one plain bullet per marker.

**Assumptions first.** Every explanation of a commit starts with the assumptions that commit took
about how the product is really used and how outside services behave (e.g. "prices are set
before service", "the voice provider returns word timings"), or says "No assumptions for this
commit". Claude thinks these through itself and does not wait to be told them; the owner can
strike one out, and the commit changes with it.

**Plain language.** Short sentences and everyday words; one small example from the project's
examples before any code; few tables and markers; no jargon without saying what it means. A
dense, long answer is a bad answer, even when it is complete. When "what does it look like"
helps, run the code with a small script in the scratchpad (fakes, saved or real local data);
read-only checks of the local database are fine.

## 4. Push back: think it through together

The review is a discussion, not a tour. Claude:

- **Counters the owner** when a suggestion has a cost or a gap, with a concrete example from the
  product (e.g. "a phone 35 minutes slow never sends 'order received'"), and says plainly where
  the owner is right.
- **Gives a recommendation**, not a list of options: the trade-off in a table, then "my
  suggestion".
- **Re-checks with a tool** before answering a doubt, and says so plainly when it was wrong.
- **Flags conflicts** between a new decision and later commits on the branch, the code rules,
  the branch plan or the todos (e.g. "the next commit already asks the owner about duplicates").
- **Splits scope**: says when an idea is its own feature (the todos) rather than this branch.
- Asks the open questions that block a decision, each with a recommended answer.

## 5. The agreed-items list

- Kept in Claude's scratchpad (`agreed-items.md`), not shown until the owner asks.
- Every change or idea agreed on, in Claude's own words: what, why, which commit it came from,
  **decided** or **open**, and now (this branch) or later (the todos).
- Updated as the discussion moves; a later decision replaces the earlier wording.

## 6. When the owner says "review is done"

1. Check the branch is back (`git branch --show-current`) and read the current code: the owner
   may have edited or squashed commits while reviewing; never undo that.
2. List every agreed item and the open questions that still block one.
3. Propose where each goes: new commits on top of the branch (code first, then docs), or the
   todos ("Later"). Name each commit and the exact files it changes.
4. Wait for "yes". Never amend, reorder or reset existing commits.
5. After the changes: run the checks, then the owner reviews the new commits the same way.

Rebuilding a branch's commits into a clean sequence is its own skill,
`/td-workflow:rebuild-commits`, and runs only when the owner asks.
