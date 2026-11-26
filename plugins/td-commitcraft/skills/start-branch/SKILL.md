---
name: start-branch
description: Start work on a branch from the branch plan, e.g. "work on feature #7". Reads the plan row, its todos, the status file and the project's stack, shows the scope, the open questions and the commit plan, and creates the branch after the owner's "yes". Use when the owner says to start, work on or pick up a branch or feature by its number or name.
---

# Start a branch

The project's values (work branch, branch names, branch plan, todos, status, run it) are in the
**This project** table of `.claude/td-commitcraft/project.md`. If
`.claude/td-commitcraft/start-branch.md` exists, read it too: the project's own rules for this
skill, which win where they differ. If `project.md` is missing, stop and suggest
`/td-commitcraft:init`.

1. **Find the row.** In the branch plan's Now table, take row #N, or the row whose branch or words
   match what the owner said. Read the todos it lists under IDs, the status file, the docs the
   row touches, and the project's stack and map (`.claude/td-codecraft/stack.md`, `map.md`) if they
   exist. If the
   row is `Merged`, or another row is `In progress`, say so and stop.
2. **Check git.** The **This branch** block at the start of the chat shows the branch and the
   tree; check again now with `git branch --show-current` and `git status`: the work branch,
   with a clean tree. Otherwise change nothing: say what you found and wait. Creating a branch
   anywhere else is blocked by the plugin's branch guard.
3. **Show the plan** in the chat, then wait for "yes":
   - the branch name (as the **Branch names** row says) and what it delivers, in the words of the
     plan and its todos;
   - what it builds, layer by layer, and what it leaves out (later rows, other todos);
   - the decisions it needs, each with a recommended answer, and any outside setup it waits on;
   - its commits, planned as `/td-commitcraft:commit-rules` says (load it if it isn't loaded);
   - how the owner will try it (the **Run it** row).
4. **After "yes":** create the branch from the work branch and set the row's Status to
   `In progress` in the branch plan (that change goes into the branch's first commit). Then build
   commit by commit with `/td-commitcraft:commit-rules`. Before writing code, follow the project's
   code rules (`/td-codecraft:code-rules` if it is available).
