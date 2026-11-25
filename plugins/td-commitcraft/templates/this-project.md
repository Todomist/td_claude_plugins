# The "This project" table: template

Copy the section below into the project's `.claude/how-we-work.md` and fill in every row. The
td-commitcraft skills take this project's values from it. Write `none` for a row that does not apply
yet. What each row is for, and which skill reads it: the plugin's `README.md`.

## This project

The `/td-commitcraft:…` skills come from the td-commitcraft plugin and take this project's values from this
table.

| What                   | Value                                                                      |
| ---------------------- | -------------------------------------------------------------------------- |
| Work branch            | `develop`: every branch starts from it and merges back into it             |
| Branch names           | `feature/<name>`, `fix/<name>`, `chore/<name>`                             |
| Checks                 | `npm run check` from the repository root (lint, format, typecheck, tests)  |
| Run it                 | How to start the app and try it end to end                                 |
| Docs                   | `.claude/docs/` (how the app works; index in its `README.md`)              |
| Status                 | The short "where we are" file, e.g. `.claude/docs/status.md`               |
| Branch plan            | The file with the release's numbered branches                              |
| Todos                  | The file with every item left for later                                    |
| Release branch         | `main`, released versions only, tagged `v<version>`; notes in …, or `none` |
| Extra planning rules   | A project file with planning rules on top of the plugin's, or `none`       |
| Review script          | `bundled` (the plugin's), or a path in this project                        |
| Local review branch    | `todomist_local/<branch>` (local only, never pushed or merged)              |
| Debug log prefix       | e.g. `vjconsole_<area>`                                                    |
| Production             | What runs in production (database, hosting), or `none`                     |
| Paid services          | Services that cost money per call, and their fakes, or `none`              |
| Examples for the owner | 2 or 3 real things from the product to explain with                        |
