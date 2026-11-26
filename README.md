# Claude Code plugins

Our one marketplace for Claude Code plugins. Every plugin lives here, in its own folder, with
its own version: today `td-commitcraft`; later more plugins, new versions and other kinds of
extensions (commands, agents, hooks, MCP servers). Never a new repository per plugin.

| Plugin                                 | Version | What it holds                                                    |
| -------------------------------------- | ------- | ---------------------------------------------------------------- |
| [td-commitcraft](plugins/td-commitcraft/README.md) | 0.1.1   | How we work in a project: plan, commit, review, rebuild, release |

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

The repository is public, so installing needs no GitHub login. Every version has a tag,
`<plugin>-v<version>`; use the latest (GitHub → Tags). For yourself only:

```
/plugin marketplace add Todomist/td_claude_plugins#td-commitcraft-v0.1.1
/plugin install td-commitcraft@todomist
```

For a whole project:

1. **In the project's `.claude/settings.json`** (committed, so everyone on the project gets it):

   ```json
   {
     "extraKnownMarketplaces": {
       "todomist": {
         "source": { "source": "github", "repo": "Todomist/td_claude_plugins", "ref": "td-commitcraft-v0.1.1" }
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

- Projects pin `ref` to a version tag, `<plugin>-v<version>` (e.g. `td-commitcraft-v0.1.1`). A
  tag never moves, so the project stays on exactly that version until it changes the tag.
- The `ref` is for the whole repository: every plugin a project uses from here comes from it.
  Plugins don't depend on each other, so that is safe.
- Auto-update is off for our marketplace: nothing changes until the project updates. To
  upgrade, on a branch in the project: change `ref` to the newer tag, then run
  `claude plugin marketplace update todomist`.

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

Work happens on `develop`, the default branch. Every push of `develop` is a new version with
its own tag. Nothing is pushed or tagged without the owner's explicit "yes".

1. While working: each change adds a line under **Unreleased** in that plugin's `CHANGELOG.md`.
2. Before the push: raise only that plugin's `version` in its `plugin.json` (patch for changes
   to existing skills; minor or major as the plugin's README says), turn **Unreleased** into
   that version in the CHANGELOG, and update the table at the top.
3. Commit, tag the commit `<plugin>-v<version>` (e.g. `td-commitcraft-v0.1.1`), then push
   `develop` and the tag. A tag never moves or gets deleted.
4. Projects get it when they move their `ref` to the new tag.

`main` holds what the Claude directory lists, and the directory follows it. It changes only when
the owner releases to the directory: merge `develop` into `main` with `--no-ff`, push `main`,
publish in the developer portal (todo R4).
