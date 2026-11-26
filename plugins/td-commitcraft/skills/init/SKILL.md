---
name: init
description: Set up a project for td-commitcraft, or move one onto it. Asks for the project's own rules and the This project values, then writes .claude/td-commitcraft/project.md and the releases folder (status, plan, todos); moves an older .claude/how-we-work.md across. Use at the start of a project, or when a project moves onto the plugin.
---

# Set up a project

Nothing is written until the owner says "yes" to the full text of every file.

## 1. Look first

- If `.claude/td-commitcraft/project.md` already exists, the project is set up: say so, and offer
  to change one part of it instead.
- Read what the repository already says, so you ask only what you cannot find: `CLAUDE.md`,
  `.claude/`, the `README.md`, the package files and scripts (`package.json`…), the git branches.
- An older `.claude/how-we-work.md` (the basics plus a This project table) is the source. Its
  table, its rows for the project's own skills, and every rule that is not one of the basics this
  plugin loads (compare with `${CLAUDE_PLUGIN_ROOT}/essentials.md`) move across. Nothing gets
  lost: list each rule and where it goes.

## 2. Ask, in one round

Ask only what you could not find, each with a suggested answer:

- The project's own rules: reference material, what never to touch, how to build and run it
  locally.
- Each row of the This project table (`${CLAUDE_PLUGIN_ROOT}/templates/project.md`); `none` where
  it does not apply yet.
- The project's own skills, and when to suggest each.

## 3. Show, then write after "yes"

- `.claude/td-commitcraft/project.md`, from the template.
- The releases folder, if it is missing: the status file, the branch plan and the todos, in the
  layouts of `/td-commitcraft:plan-release`
  (`${CLAUDE_PLUGIN_ROOT}/skills/plan-release/plan-release.md`).
- `CLAUDE.md`: if it is missing, a short one that loads the status file (`@<status file>`). If it
  loads `.claude/how-we-work.md`, propose removing that line: the plugin loads its basics and
  `project.md` itself.
- An older `.claude/how-we-work.md`: propose deleting it once its content has moved. The owner
  decides.

Don't commit: list the changed files and suggest `/td-commitcraft:commit-rules`. If
`/td-codecraft:init` is available, suggest it next, for the project's stack.
