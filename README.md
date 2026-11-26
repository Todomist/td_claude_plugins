# Claude Code plugins

Our one marketplace for Claude Code plugins. Every plugin lives here, in its own folder, with
its own version: today `td-commitcraft` and `td-codecraft`; later more plugins, new versions and other kinds of
extensions (commands, agents, hooks, MCP servers). Never a new repository per plugin.

| Plugin                                 | Version | What it holds                                                    |
| -------------------------------------- | ------- | ---------------------------------------------------------------- |
| [td-commitcraft](plugins/td-commitcraft/README.md) | 0.1.2   | How we work in a project: plan, commit, review, rebuild, release |
| [td-codecraft](plugins/td-codecraft/README.md)     | 0.1.0   | How we write code: the stack, its decisions, the code rules      |

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
`<plugin>-v<version>`. A `ref` is for the whole repository, so the newest tag of any plugin
(GitHub → Tags) serves every plugin from here. For yourself only:

```
/plugin marketplace add Todomist/td_claude_plugins#td-commitcraft-v0.1.2
/plugin install td-commitcraft@todomist
/plugin install td-codecraft@todomist
```

For a whole project:

1. **In the project's `.claude/settings.json`** (committed, so everyone on the project gets it):

   ```json
   {
     "extraKnownMarketplaces": {
       "todomist": {
         "source": { "source": "github", "repo": "Todomist/td_claude_plugins", "ref": "td-commitcraft-v0.1.2" }
       }
     },
     "enabledPlugins": { "td-commitcraft@todomist": true, "td-codecraft@todomist": true }
   }
   ```

2. **Once per clone:** open the project in Claude Code, trust the folder, then run
   `claude plugin install td-commitcraft@todomist --scope project` and the same for
   `td-codecraft@todomist`.
3. **Run `/td-commitcraft:init`:** it asks for the project's own rules and the This project
   values and writes `.claude/td-commitcraft/project.md`
   ([template](plugins/td-commitcraft/templates/project.md)) and the releases folder. The plugin
   loads its basics and `project.md` in every chat: `CLAUDE.md` needs no line for either.
4. **Run `/td-codecraft:init`:** it asks what the project is built with and writes
   `.claude/td-codecraft/stack.md` and the project's own `.claude/td-codecraft/code-rules.md`
   ([templates](plugins/td-codecraft/templates/)).

### Pin and upgrade

- Projects pin `ref` to a version tag, `<plugin>-v<version>` (e.g. `td-commitcraft-v0.1.2`). A
  tag never moves, so the project stays on exactly that version until it changes the tag.
- The `ref` is for the whole repository: every plugin a project uses from here comes from it.
  Plugins don't depend on each other, so that is safe.
- Auto-update is off for our marketplace: nothing changes until the project updates. To
  upgrade, on a branch in the project: change `ref` to the newer tag, then run
  `claude plugin marketplace update todomist`.

### Switch a project from its local copies

On one branch in that project, after the owner's "yes":

1. Add the settings above and install the plugin.
2. Delete the local copies: `.claude/skills/{plan-release,commit-rules,review-commits,rebuild-commits}/`
   and `.claude/scripts/review-commits.sh`. Keeping both would show two wordings
   (`/commit-rules` and `/td-commitcraft:commit-rules`).
3. Run `/td-commitcraft:init`: it moves the project's own rules, its This project table and its
   own skills from `.claude/how-we-work.md` into `.claude/td-commitcraft/project.md`. Then delete
   `.claude/how-we-work.md` and its line in `CLAUDE.md`: the plugin loads the basics itself.
   Rename the skills to `/td-commitcraft:…` in `.claude/skills/README.md` and `CLAUDE.md`.
4. Run `/td-codecraft:init`: it sorts every rule of the old `.claude/skills/code-rules/` into
   dropped (the plugin has it), `stack.md` (a choice or a value) or the project's own
   `code-rules.md`, so nothing is lost. Then delete `.claude/skills/code-rules/` and rename
   `/code-rules` to `/td-codecraft:code-rules` where the project mentions it.
5. In a new chat: the basics and `project.md` are loaded, `/td-commitcraft:commit-rules` and
   `/td-codecraft:code-rules` load, and `/td-commitcraft:review-commits` gives the review script's
   full path.

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
3. Commit, tag the commit `<plugin>-v<version>` (e.g. `td-commitcraft-v0.1.2`), then push
   `develop` and the tag. A tag never moves or gets deleted.
4. Move the marketplace on this machine to the new tag, so projects can fetch it.
   `claude plugin marketplace update todomist` alone keeps the old tag:

   ```
   claude plugin marketplace add "Todomist/td_claude_plugins#<plugin>-v<version>"
   ```

5. Each project updates itself, when it wants and on its own branch: it moves its `ref` in
   `.claude/settings.json` to the new tag, runs
   `claude plugin update <plugin>@todomist --scope project`, and restarts Claude Code. Releasing
   from this repository never updates a project's installed plugin.

`main` holds what the Claude directory lists, and the directory follows it. It changes only when
the owner releases to the directory: merge `develop` into `main` with `--no-ff`, push `main`,
publish in the developer portal (todo R4).
