#!/bin/sh
# td-commitcraft, SessionStart: prints the plugin's version, its basics, the project's
# .claude/td-commitcraft/project.md and a "This branch" block. Read-only; always exits 0.

plugin=${CLAUDE_PLUGIN_ROOT:-$(dirname "$0")/..}
root=${CLAUDE_PROJECT_DIR:-$PWD}
project="$root/.claude/td-commitcraft/project.md"

version=$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' "$plugin/.claude-plugin/plugin.json" 2>/dev/null | head -n 1)
echo "td-commitcraft ${version:-?}, loaded at the start of this chat."
echo
cat "$plugin/essentials.md" 2>/dev/null
echo
if [ -f "$project" ]; then
  cat "$project"
else
  echo "This project has no .claude/td-commitcraft/project.md yet: suggest /td-commitcraft:init."
fi

# The backticked value of a This project row: row "Work branch" -> develop
row() { [ -f "$project" ] && grep -m 1 "^| $1 " "$project" | sed -n 's/^[^`]*`\([^`]*\)`.*/\1/p'; }
# One section of branch-essentials.md, without its heading
section() { sed -n "/^## $1\$/,/^## /p" "$plugin/branch-essentials.md" 2>/dev/null | sed '/^## /d'; }

git -C "$root" rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

echo
echo "## This branch"
echo
work=$(row "Work branch")
if [ -z "$work" ]; then
  work=develop
  if [ -f "$project" ]; then
    echo "No Work branch row in .claude/td-commitcraft/project.md: taking \`develop\`."
  else
    echo "No .claude/td-commitcraft/project.md: taking \`develop\` as the work branch."
  fi
fi
branch=$(git -C "$root" branch --show-current 2>/dev/null)
if [ -n "$(git -C "$root" status --porcelain --untracked-files=no 2>/dev/null)" ]; then
  tree="uncommitted changes"
else
  tree="clean"
fi

if [ -z "$branch" ]; then
  echo "Detached HEAD ($tree): a commit-by-commit review may be running. Change nothing until the"
  echo "branch is back (\`git branch --show-current\`)."
  exit 0
fi

echo "Branch \`$branch\` ($tree); the work branch is \`$work\`."
if [ "$branch" = "$work" ]; then
  section "Starting a branch"
else
  plan=$(row "Branch plan")
  if [ -z "$plan" ]; then
    echo "No Branch plan row in .claude/td-commitcraft/project.md."
  elif [ ! -f "$root/$plan" ]; then
    echo "The branch plan ($plan) is missing."
  else
    line=$(grep -F "\`$branch\`" "$root/$plan" | head -n 1)
    if [ -n "$line" ]; then
      echo "Its row in $plan:"
      echo "$line"
    else
      echo "\`$branch\` is not in the branch plan ($plan)."
    fi
  fi
  section "On a branch"
fi
exit 0
