#!/bin/sh
# td-commitcraft, PreToolUse on Bash: a new branch (git checkout -b, git switch -c) starts only
# from a clean work branch. Read-only. Exit 2 with a reason on stderr blocks the command; exit 0
# lets it run.

input=$(cat)
printf '%s' "$input" | grep -Eq 'git[[:space:]]+(checkout[[:space:]]+-b|switch[[:space:]]+-c)[[:space:]]' || exit 0

root=${CLAUDE_PROJECT_DIR:-$PWD}
git -C "$root" rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0
project="$root/.claude/td-commitcraft/project.md"
work=""
[ -f "$project" ] && work=$(grep -m 1 "^| Work branch " "$project" | sed -n 's/^[^`]*`\([^`]*\)`.*/\1/p')
work=${work:-develop}
branch=$(git -C "$root" branch --show-current 2>/dev/null)

if [ "$branch" != "$work" ]; then
  echo "td-commitcraft: a new branch starts from the work branch ($work), but this is ${branch:-a detached HEAD}. Change nothing; ask the owner to switch to $work." >&2
  exit 2
fi
if [ -n "$(git -C "$root" status --porcelain --untracked-files=no 2>/dev/null)" ]; then
  echo "td-commitcraft: $work has uncommitted changes; a new branch starts from a clean $work. Ask the owner what to do with them." >&2
  exit 2
fi
exit 0
