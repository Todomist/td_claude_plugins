# Privacy

td-commitcraft is a set of instructions (skills) for Claude Code. It collects no data, stores no
data and sends nothing anywhere: it has no MCP servers and no network access. Its two hooks only
read: at the start of every chat one prints local files (the plugin's basics, the project's
`.claude/td-commitcraft/project.md`) and the current branch's state from git; before Claude
creates a branch the other checks the current branch and `git status`. Its script
`review-commits.sh` runs only when the user starts it in a terminal, and uses git on the current
repository only.

The skills work on the user's own project through Claude Code's normal tools (reading files,
running git and the project's checks), with the user's permission. What Claude Code itself does
with that work is covered by Anthropic's terms and privacy policy, not by this plugin.

Questions: https://github.com/Todomist/td_claude_plugins/issues
