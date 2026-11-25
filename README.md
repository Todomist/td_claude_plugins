# Claude Code plugins

Our one marketplace for Claude Code plugins. Every plugin lives here, in its own folder, with
its own version: today `td-commitcraft`; later more plugins, new versions and other kinds of
extensions (commands, agents, hooks, MCP servers). Never a new repository per plugin.

| Plugin                                 | Version | What it holds                                                    |
| -------------------------------------- | ------- | ---------------------------------------------------------------- |
| [td-commitcraft](plugins/td-commitcraft/README.md) | 0.1.0   | How we work in a project: plan, commit, review, rebuild, release |

Planned next: [.claude/todo.md](.claude/todo.md).

## How it fits together

- `.claude-plugin/marketplace.json` lists every plugin. The marketplace is called `todomist`.
- Every plugin is named `td-<name>`, so its name is unique in the Claude directory.
- Each plugin is one folder, `plugins/td-<name>/`: `.claude-plugin/plugin.json` (name, version), a
  `README.md`, a `CHANGELOG.md`, and its parts (`skills/`, later `commands/`, `agents/`,
  `hooks/`, `.mcp.json`).
- Plugins never depend on each other and never use files outside their own folder (those are
  not copied when a plugin is installed).
- A plugin's skills are called with its name in front: `/td-commitcraft:commit-rules`.
- When a project installs a plugin, Claude Code copies that plugin's folder to
  `~/.claude/plugins/cache/todomist/<plugin>/<version>/` and runs that copy.

## Use a plugin in a project

The repository is public, so installing needs no GitHub login. For yourself only, from `main`
(the default branch, `develop`, holds unreleased work):

```
/plugin marketplace add Todomist/td_claude_plugins#main
/plugin install td-commitcraft@todomist
```

For a whole project:

1. **In the project's `.claude/settings.json`** (committed, so everyone on the project gets it):

   ```json
   {
     "extraKnownMarketplaces": {
       "todomist": {
         "source": { "source": "github", "repo": "Todomist/td_claude_plugins", "ref": "main" }
       }
     },
     "enabledPlugins": { "td-commitcraft@todomist": true }
   }
   ```

2. **Once per clone:** open the project in Claude Code, trust the folder, then run
   `claude plugin install td-commitcraft@todomist --scope project`.
3. **Add the This project table** to the project's `.claude/how-we-work.md`:
   [template](plugins/td-commitcraft/templates/this-project.md).

### Pin and upgrade

- `"ref": "main"` follows released versions only, because `main` changes only through a release.
  Without `ref` the project follows `develop`, the default branch, which holds unreleased work.
  We don't use tags; to stay on one exact release, `ref` can be its full 40-character commit SHA.
- The `ref` is for the whole repository: every plugin a project uses from here comes from it.
  Plugins don't depend on each other, so that is safe.
- Auto-update is off for our marketplace: nothing changes until the project updates. To get the
  latest release, run `claude plugin marketplace update todomist`.

### Switch a project from its local copies

On one branch in that project, after the owner's "yes":

1. Add the settings above and install the plugin.
2. Delete the local copies: `.claude/skills/{commit-rules,review-commits,rebuild-commits}/`,
   `.claude/scripts/review-commits.sh`, and the planning and release rules that now live in
   `/td-commitcraft:plan-release`. Keeping both would show two wordings (`/commit-rules` and
   `/td-commitcraft:commit-rules`).
3. In `.claude/how-we-work.md`, `.claude/skills/README.md` and `CLAUDE.md`: add or update the
   This project table, and rename the skills to `/td-commitcraft:…`.
4. In a new chat: `/td-commitcraft:commit-rules` loads, and `/td-commitcraft:review-commits` gives
   the review script's full path.

## Work on this repository

- Try a plugin without installing it: `claude --plugin-dir ./plugins/td-commitcraft`. After an edit,
  `/reload-plugins`.
- Before every commit: `claude plugin validate . --strict` and
  `claude plugin validate ./plugins/td-<name> --strict`.

### Add a plugin

1. `plugins/td-<name>/` with `.claude-plugin/plugin.json` (`name: "td-<name>"`,
   `version: "0.1.0"`, `description`, `author`, `license: "MIT"`), `README.md`, `CHANGELOG.md`,
   a square PNG icon at `.claude-plugin/icon.png` and its parts.
2. One entry in `.claude-plugin/marketplace.json`:
   `{ "name": "td-<name>", "source": "./plugins/td-<name>", "description": "…" }`. No `version`
   there: it lives in `plugin.json` only.
3. One row in the table at the top of this file.

### Release a new version

Work happens on `develop`, the default branch. `main` holds released versions only: the owner
creates it and pushes to it, by hand or through a CI/CD pipeline. Nothing is released or pushed
without the owner's explicit "yes". We don't use tags.

1. While working: each change adds a line under **Unreleased** in that plugin's `CHANGELOG.md`.
   The version stays as it is.
2. To release: on `develop`, raise only that plugin's `version` in its `plugin.json` (major,
   minor or patch: the plugin's README says which), turn **Unreleased** into that version in the
   CHANGELOG, and update the table at the top.
3. Merge into `main` with `--no-ff`, then push `main`.
4. The Claude directory follows `main`: publish the new version in the developer portal.
   Projects following `main` get it when they run `claude plugin marketplace update todomist`.
