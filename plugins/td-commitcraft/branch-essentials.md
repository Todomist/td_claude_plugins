## Starting a branch

No branch in progress here; to start one, follow `/td-commitcraft:start-branch`:

1. Find the plan row (by number or name) and the todos it lists.
2. Stay on a clean work branch.
3. Show the scope, the open questions and the commit plan; wait for "yes".
4. Create the branch from the work branch and set its row In progress.

## On a branch

- Plan the commits and wait for "yes"; load `/td-commitcraft:commit-rules` before the first commit.
- Tests go in the same commit as the code they test.
- Right before every commit: check the branch, then run the checks.
- One docs commit at the end; `TEMP` debug logs last.
