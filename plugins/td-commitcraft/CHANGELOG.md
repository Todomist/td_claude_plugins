# Changelog

## Unreleased

- `review-commits` and its script are out of this version: the Claude directory accepts scripts
  only from verified organizations. They come back in a later version. The **Review script** row
  now always names a script in the project.
- Renamed from `td-workflow` to `td-commitcraft`: the skills are now `/td-commitcraft:…`. The
  author is Todomist.
- Work branch and release branch: work happens on the work branch (`develop`); the release
  branch (`main`) holds released versions only. A release merges the work branch into the
  release branch with `--no-ff` and tags it, only after the owner's "yes". `plan-release` no
  longer cuts `release/<version>-<description>` branches.
- This project table: **Main branch** is now **Work branch**, and **Releases** is now
  **Release branch**.

## 0.1.0

- First version. Each skill is one wording, merged from the copies our projects kept in
  `.claude/skills/`: `commit-rules`, `review-commits` (with `review-commits.sh` bundled) and
  `rebuild-commits`.
- New `plan-release`: planning a release in branches, the branch plan, the todos, the status
  file, releases and versions (until now a project's release notes and its commit rules).
- Project values come from the **This project** table; template in `templates/this-project.md`.
