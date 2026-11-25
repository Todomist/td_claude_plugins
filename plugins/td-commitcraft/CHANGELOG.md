# Changelog

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
