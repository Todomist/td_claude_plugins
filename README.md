# Claude Code plugins

Our one marketplace for Claude Code plugins. Every plugin lives here, in its own folder, with
its own version: today `workflow`; later more plugins, new versions and other kinds of
extensions (commands, agents, hooks, MCP servers). Never a new repository per plugin.

| Plugin                                 | Version | What it holds                                                    |
| -------------------------------------- | ------- | ---------------------------------------------------------------- |
| [workflow](plugins/workflow/README.md) | 0.1.0   | How we work in a project: plan, commit, review, rebuild, release |

Planned next: [.claude/todo.md](.claude/todo.md).

## How it fits together

- `.claude-plugin/marketplace.json` lists every plugin. The marketplace is called `todomist`.
- Each plugin is one folder, `plugins/<name>/`: `.claude-plugin/plugin.json` (name, version), a
  `README.md`, a `CHANGELOG.md`, and its parts (`skills/`, later `commands/`, `agents/`,
  `hooks/`, `.mcp.json`).
- Plugins never depend on each other and never use files outside their own folder (those are
  not copied when a plugin is installed).
- A plugin's skills are called with its name in front: `/workflow:commit-rules`.
- When a project installs a plugin, Claude Code copies that plugin's folder to
  `~/.claude/plugins/cache/todomist/<plugin>/<version>/` and runs that copy.

## Use a plugin in a project

1. **Once per machine, while the repository is private:** git must reach GitHub without a
   prompt. `brew install gh`, `gh auth login`, `gh auth setup-git` (or an SSH key without a
   passphrase). A `GITHUB_TOKEN` in the environment alone is not enough.
2. **In the project's `.claude/settings.json`** (committed, so everyone on the project gets it):

   ```json
   {
     "extraKnownMarketplaces": {
       "todomist": {
         "source": { "source": "github", "repo": "<owner>/claude_plugins", "ref": "workflow-v0.1.0" }
       }
     },
     "enabledPlugins": { "workflow@todomist": true }
   }
   ```

3. **Once per clone:** open the project in Claude Code, trust the folder, then run
   `claude plugin install workflow@todomist --scope project`.
4. **Add the This project table** to the project's `.claude/how-we-work.md`:
   [template](plugins/workflow/templates/this-project.md).

### Pin and upgrade

- `ref` pins the marketplace to a tag (`workflow-v0.1.0`) or a full 40-character commit SHA.
  Without `ref` the project follows the repository's default branch (`develop`).
- The pin is for the whole repository: every plugin a project uses from here comes from that
  tag. Plugins don't depend on each other, so that is safe.
- Auto-update is off for our marketplace: nothing changes until the project updates.
- To upgrade, on a branch in the project: change `ref` to the newer tag, then run
  `claude plugin marketplace update todomist`.

### Switch a project from its local copies

On one branch in that project, after the owner's "yes":

1. Add the settings above and install the plugin.
2. Delete the local copies: `.claude/skills/{commit-rules,review-commits,rebuild-commits}/`,
   `.claude/scripts/review-commits.sh`, and the planning and release rules that now live in
   `/workflow:plan-release`. Keeping both would show two wordings (`/commit-rules` and
   `/workflow:commit-rules`).
3. In `.claude/how-we-work.md`, `.claude/skills/README.md` and `CLAUDE.md`: add or update the
   This project table, and rename the skills to `/workflow:…`.
4. In a new chat: `/workflow:commit-rules` loads, and `/workflow:review-commits` gives the
   review script's full path.

## Work on this repository

- Try a plugin without installing it: `claude --plugin-dir ./plugins/workflow`. After an edit,
  `/reload-plugins`.
- Before every commit: `claude plugin validate . --strict` and
  `claude plugin validate ./plugins/<name> --strict`.

### Add a plugin

1. `plugins/<name>/` with `.claude-plugin/plugin.json` (`name`, `version: "0.1.0"`,
   `description`, `author`), `README.md`, `CHANGELOG.md` and its parts.
2. One entry in `.claude-plugin/marketplace.json`:
   `{ "name": "<name>", "source": "./plugins/<name>", "description": "…" }`. No `version` there:
   it lives in `plugin.json` only.
3. One row in the table at the top of this file.

### Release a new version

1. Raise only that plugin's `version` in its `plugin.json` (major, minor or patch: the plugin's
   README says which), add a `CHANGELOG.md` entry, and update the table at the top.
2. Tag the commit on `develop`: `git tag <plugin>-v<version>` (e.g. `workflow-v1.1.0`).
3. Projects get it when they move their `ref` to the new tag. The same version means no update,
   even with new commits.
