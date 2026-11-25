# Claude Code plugins: read before working

This repository is our one marketplace for Claude Code plugins. Its layout, how a project
installs a plugin, and how to add a plugin or release a version: [README.md](README.md).
Planned work: [.claude/todo.md](.claude/todo.md).

## How we work here

- Plan first. Before changing anything, list exactly what will change and wait for "yes".
- Keep it simple and short.
- Git: work happens on `develop` (or a branch, if the owner asks for one). `main` holds released
  versions only and changes only through a release (README, "Release a new version"). Never
  push or merge unless asked. Never amend, reset or rewrite existing commits. Never add Claude as a
  co-author.
- Other projects are read only from here: a project changes only in its own repository, on its
  own branch.

## Rules for plugins

- Every plugin is named `td-<name>`, so its name is unique in the Claude directory. One folder
  per plugin, `plugins/td-<name>/`, with its own `plugin.json` version, `README.md` and
  `CHANGELOG.md`, plus one entry in `.claude-plugin/marketplace.json`.
- Plugins never depend on each other and never use files outside their own folder.
- Skills stay general: project values come from the project's **This project** table (the
  `td-workflow` README is the contract). Project-only skills stay in their projects.
- A change projects should get raises that plugin's version, and only that plugin's, with a
  `CHANGELOG.md` entry. `version` lives in `plugin.json` only, never in the marketplace entry.
- A skill points to its own files with `${CLAUDE_PLUGIN_ROOT}` in `SKILL.md`. The variable is
  replaced only in `SKILL.md`, not in the files it points to.
- The repository is public: no secrets, and no private details from our projects.
- Before every commit: `claude plugin validate . --strict` and
  `claude plugin validate ./plugins/td-<name> --strict`.
