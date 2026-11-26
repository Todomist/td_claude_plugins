# Changelog

## Unreleased

- `plan-release` is the version finalised in our projects: the status, the branch plan (Now and
  Next) and the todos sit at the top of the releases folder; the todos are one table with a Done
  date; finishing touches picks what the release still needs; a release branch is cut from the
  work branch, built and deployed, then merged into the branches the **Release branch** row
  names; each shipped release gets its own version folder. New table row **Releases folder**;
  the **Release branch** row now names the branch and where it merges.
- `review-commits` is back, with its script `review-commits.sh`, which the owner runs in a
  terminal. It may read `.env` files and logs during a review. The **Review script** row can say
  `bundled` again.
- README: install from `main` (`/plugin marketplace add Todomist/td_claude_plugins#main`), not
  from the default branch, which holds unreleased work.

## 0.1.0

- First version: `plan-release`, `commit-rules` and `rebuild-commits`. Each skill is one wording,
  merged from the copies our projects kept in `.claude/skills/`. `plan-release` is new: planning
  a release in branches, the branch plan, the todos, the status file, releases and versions.
- Work branch and release branch: work happens on the work branch (`develop`); the release
  branch (`main`) holds released versions only. A release merges the work branch into the
  release branch with `--no-ff` and tags it, only after the owner's "yes".
- Project values come from the **This project** table; template in `templates/this-project.md`.
- Listing details in `plugin.json` (display name, keywords, links) and a privacy note in
  `PRIVACY.md`: the plugin collects, stores and sends no data.
- `review-commits` and its script come in a later version: the Claude directory accepts scripts
  only from verified organizations. Until then the **Review script** row names a script in the
  project.
