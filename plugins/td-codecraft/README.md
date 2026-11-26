# td-codecraft

How we write code, and a record of every tech decision. `init` asks what a project is built with
and writes its `.claude/td-codecraft/stack.md`; `decide` keeps it current; `code-rules` gives one
set of rules for the code, the database, the API and the app, on top of the project's own; `map`
writes `.claude/td-codecraft/map.md`, what an existing project contains and where it lives.

Install it for yourself:

```
/plugin marketplace add Todomist/td_claude_plugins#td-codecraft-v0.1.2
/plugin install td-codecraft@todomist
```

For a whole project, and to pin a version: the repository's [README](../../README.md).

| Skill                      | When to use                                                                              |
| -------------------------- | ---------------------------------------------------------------------------------------- |
| `/td-codecraft:init`       | Starting a project, or moving one onto the plugin: writes `stack.md` and `code-rules.md` |
| `/td-codecraft:decide`     | A chat settles a tech decision: a library, a pattern, a convention, a service            |
| `/td-codecraft:code-rules` | Before writing, changing or reviewing code, a table, an endpoint, a screen               |
| `/td-codecraft:map`        | An existing project has no map yet, or a branch added a feature, table, route or screen  |

## The contract: `.claude/td-codecraft/`

| File            | What it holds                                                                    | Template                                    |
| --------------- | -------------------------------------------------------------------------------- | ------------------------------------------- |
| `stack.md`      | The stack, the conventions, the approved libraries and the decision log          | [templates/stack.md](templates/stack.md)           |
| `code-rules.md` | The project's own code rules, on top of the plugin's; they win where they differ | [templates/code-rules.md](templates/code-rules.md) |
| `map.md`        | What the project is and where everything lives, linking to its deeper docs       | [templates/map.md](templates/map.md)               |

## What it runs

No MCP servers, no scripts, no network access, and it stores no data. The skills are
instructions for Claude. Privacy: [PRIVACY.md](PRIVACY.md).

- A `SessionStart` hook (`hooks/hooks.json`, a one-line command, no script file) prints, at the
  start of every chat: the plugin's name and version (from `plugin.json`), `essentials.md` (when
  to suggest these skills), and a one-line note when the project has no `stack.md` yet. It reads
  nothing else and writes nothing.

## Versions

`MAJOR.MINOR.PATCH`, in `.claude-plugin/plugin.json`; what changed is in
[CHANGELOG.md](CHANGELOG.md). Patch for changes to existing skills, minor for a new skill or part,
major for a big rework. Each push turns the CHANGELOG's Unreleased into a new version with a tag,
`td-codecraft-v<version>`, which never moves.
