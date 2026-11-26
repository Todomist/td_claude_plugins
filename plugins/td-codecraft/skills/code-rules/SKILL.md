---
name: code-rules
description: How we write code - the code itself, database tables and migrations, API routes, and app screens and components, plus what a debug log may contain - on top of the project's stack and its own rules. Use before writing, changing or reviewing code, a table or migration, an endpoint, a screen or a component.
---

First read the project's `.claude/td-codecraft/stack.md` (its stack, conventions, approved
libraries and decisions), `.claude/td-codecraft/code-rules.md` (its own rules) and, if it exists,
`.claude/td-codecraft/map.md` (where everything lives). If `stack.md` is missing, suggest
`/td-codecraft:init`.

Then open `code-rules.md` in this folder (`${CLAUDE_PLUGIN_ROOT}/skills/code-rules/`) and read
only the sections for what is being built, together with the same sections of the project's own
file:

| Building                                 | Sections                          |
| ---------------------------------------- | --------------------------------- |
| A table or migration                     | Database                          |
| An endpoint                              | API, plus Database if it adds SQL |
| A screen, component, hook or theme value | App                               |
| Shared logic                             | Code                              |
| Debug logs                               | Code                              |
| Anything                                 | Code                              |

The project's rules win where they differ. A section for a part the stack doesn't have does not
apply. When in doubt, copy the nearest existing example in the repo. A new tech decision made
while building (a library, a pattern, a convention) is recorded with `/td-codecraft:decide`.
