---
name: init
description: Set up a project's stack for td-codecraft, or move one onto it. Asks what the project is built with and writes .claude/td-codecraft/stack.md (stack, conventions, approved libraries, decisions) and .claude/td-codecraft/code-rules.md (its own code rules); moves an older .claude/skills/code-rules/ across. Use at the start of a project, or when a project moves onto the plugin.
---

# Set up the stack

Nothing is written until the owner says "yes" to the full text of both files.

## 1. Look first

- If `.claude/td-codecraft/stack.md` already exists, the stack is set up: say so, and offer
  `/td-codecraft:decide` for a change instead.
- Read what the repository already says, so you ask only what you cannot find: the package
  files and lockfiles, configs (TypeScript, linters, Expo, Vite…), the folder layout, existing
  migrations and env examples, `CLAUDE.md`, `.claude/`.
- An older `.claude/skills/code-rules/` is the source. Sort every rule in it into one of three,
  and show the three lists, so nothing gets lost:
  - **already in the plugin's rules** (`${CLAUDE_PLUGIN_ROOT}/skills/code-rules/code-rules.md`):
    dropped;
  - **a choice or a value** (a library, a folder, a unit, a time zone, a package name): into
    `stack.md`, as a Stack or Conventions row, an approved library, or a decision;
  - **a rule only this project has**: into the project's `code-rules.md`, under the same section.

## 2. What the project already does differently

The plugin's rules (`${CLAUDE_PLUGIN_ROOT}/skills/code-rules/code-rules.md`) forbid some things
and allow others only as a recorded decision. Search the project for each one that already
exists, for example: a JSON or JSONB column in the migrations, a state library or a schema
library in the package files, money in a `numeric`, `real`, `float` or `double` column, a time
column that is not `timestamptz`, number ids (`serial`, `integer` keys) instead of `uuid`, rows
removed with `DELETE`, raw colours or sizes in components. Propose one Decisions row for each,
naming the file it was found in, so an existing project is not "wrong" on its first day. The
owner keeps, changes or drops each row.

## 3. Ask, in one round

Ask only what you could not find, each with a suggested answer: language, runtime, repository
layout, shared package, database and migrations folder, API, app, tests, format and lint,
hosting, outside services; the conventions (owner column, money unit, time zone, phone numbers,
server secrets file, client app names); the approved libraries.

## 4. Show, then write after "yes"

- `.claude/td-codecraft/stack.md` and `.claude/td-codecraft/code-rules.md`, from
  `${CLAUDE_PLUGIN_ROOT}/templates/`. The choices made now, and the rows the owner kept from
  step 2, go into Decisions as D1, D2… with today's date, written `26 Nov 2026`.
- An older `.claude/skills/code-rules/`: propose deleting it once its rules have moved, and
  renaming `/code-rules` to `/td-codecraft:code-rules` where the project mentions it. The owner
  decides.

Don't commit: list the changed files and suggest the project's commit rules
(`/td-commitcraft:commit-rules` if it is available).
