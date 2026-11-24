#!/usr/bin/env bash
# Step through the commits of the current branch one at a time. Each commit is shown as
# staged changes (detached HEAD + reset --soft), so the IDE / GitHub Desktop "Changes" panel
# shows only that commit's diff. The branch itself is never moved.
#
# Usage (from the branch you want to review, with a clean working tree). The
# /workflow:review-commits skill gives the full path to this file:
#   bash review-commits.sh            # base = develop
#   bash review-commits.sh main       # custom base
#   bash review-commits.sh develop 3  # start at commit #3
#
# Keys at each step:  Enter/n = next   p = previous   number = jump   q = quit
# Any edits made while reviewing are discarded when moving on.

set -euo pipefail

base="${1:-develop}"
start="${2:-1}"
branch="$(git branch --show-current)"

if [[ -z "$branch" ]]; then
  echo "Not on a branch (detached HEAD). Check out the branch to review first."
  exit 1
fi
if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
  echo "Working tree has uncommitted changes. Commit or stash them first."
  exit 1
fi

commits=()
while IFS= read -r sha; do commits+=("$sha"); done < <(git rev-list --reverse --no-merges "$base..$branch")
total=${#commits[@]}

if (( total == 0 )); then
  echo "No commits on $branch that are not on $base."
  exit 0
fi

restore() {
  git checkout -q -f "$branch"
  echo
  echo "Back on $branch ($(git log -1 --format='%h %s'))"
}
trap restore EXIT

echo "Reviewing $total commit(s) on $branch (base $base):"
for i in "${!commits[@]}"; do
  echo "  $((i + 1)). $(git log -1 --format='%h %s' "${commits[$i]}")"
done

i=$((start - 1))
while (( i >= 0 && i < total )); do
  sha="${commits[$i]}"
  git checkout -q -f --detach "$sha"
  git reset -q --soft HEAD~1

  echo
  echo "=== [$((i + 1))/$total] $(git log -1 --format='%h %s' "$sha") ==="
  git diff --cached --stat | cat
  echo "Changes are staged. Enter/n = next, p = previous, <number> = jump, q = quit"

  read -r answer
  case "$answer" in
    q) break ;;
    p) (( i > 0 )) && i=$((i - 1)) ;;
    ''|n) i=$((i + 1)) ;;
    *[!0-9]*) echo "Unknown key, showing same commit." ;;
    *) (( answer >= 1 && answer <= total )) && i=$((answer - 1)) ;;
  esac
done
