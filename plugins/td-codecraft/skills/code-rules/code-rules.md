# Code rules

How we write code. Short on purpose: when in doubt, copy the nearest existing example. The
project's stack, conventions and decisions are in `.claude/td-codecraft/stack.md`, and its own
rules in `.claude/td-codecraft/code-rules.md`: where they differ from these, the project wins. A
section for a part the stack doesn't have does not apply. Words in angle brackets
(`<shared package>`, `<owner column>`…) mean the values in `stack.md`.

## Code

- Language, formatter, linter and test runner: as `stack.md` says. Run the project's checks
  before committing.
- Run the formatter and the linter from the repository root, never inside a workspace: only the
  root's ignore files keep generated and copied files untouched.
- A short doc comment above every important module, function, component and hook: what it does
  and anything surprising (side effects, why it exists). Skip the obvious. Other comments: few,
  short, only when needed.
- Debug logs are temporary and prefixed `[<debug log prefix>_<area>]` (the **Debug log prefix** row of
  `.claude/td-commitcraft/project.md`). Log only fields that really come from the outside event (the backend, a provider, the
  queue: no app-derived or mapped values) and put the whole event last:
  `completeEvent: message`. Never log a secret, a key or a signed URL.
- Few libraries. Prefer built-ins (the runtime's `crypto`, `fetch` and test runner; React's
  Context + `useReducer`). The approved libraries are in `stack.md`; a new one is asked for first,
  then recorded with `/td-codecraft:decide`.
- `<shared package>` holds types and pure logic used by both the app and the server, and the
  error codes: no runtime code (Node, React Native, the database) in it.
- Where Node runs TypeScript directly, server and shared code import with `.ts` paths
  (`./money.ts`).

## Database (PostgreSQL)

- **Names:** snake_case; tables plural (`orders`); foreign keys `<thing>_id`; indexes
  `<table>_<columns>_idx`.
- **IDs:** `uuid` from `gen_random_uuid()`. Numbers people see (order #1042) are separate
  counters.
- **Time:** `timestamptz` only. Every table has `created_at` and `updated_at` (kept current by
  the `set_updated_at` trigger). Events are `<verb>_at` (`done_at`, `delivered_at`). "Today" is
  the calendar day in the project's time zone (`stack.md`).
- **Money:** integers in the project's smallest unit (`stack.md`), never floats.
- **Fixed value sets:** `text` + `CHECK (… IN (…))`, values in lower_snake_case (`'non_veg'`).
  Adding a value is a new migration.
- **Scoping:** every row someone owns has `<owner column>`, and every query filters by it, taken
  from the request's identity, never from the request body.
- **History:** a record copies what later edits would change (an order copies item names and
  prices), so past records never change. Derived values (totals, stats) are calculated, not
  stored.
- **Nothing is deleted:** never remove rows; a row that goes is marked (`deleted_at`). Only the
  owner decides to delete data, by hand.
- **Reuse before adding.** Before a new table, check whether an existing one can hold it as a
  column or a row. Add a table only for a new kind of thing with its own life, never a catch-all
  table or a JSON blob to avoid one; a JSON column only where `stack.md` records it as a
  decision. Propose every new table for review first.
- **Migrations:** numbered files `NNN_description.sql` in the migrations folder (`stack.md`), run
  with `psql -v ON_ERROR_STOP=1 -f …`. Each is wrapped in `BEGIN`/`COMMIT` and ends by inserting
  its row into `schema_migrations`. A migration can still be edited until its branch is merged
  (reset your local database afterwards); once merged, never edit it: add a new one. A new table
  gets `created_at`/`updated_at` + trigger, and `<owner column>` if someone owns it.

## API (Fastify)

- REST over JSON under **`/v1`**, camelCase fields. One API for every client app.
- **One folder per feature** in `apps/server/src/modules/<feature>/`: `<feature>.routes.ts`
  (thin handlers), `<feature>.schemas.ts` (Fastify schemas), `<feature>.service.ts` (logic),
  `<feature>.repository.ts` (all SQL). Register the module in `src/modules.ts`, the only shared
  file a feature touches. Features don't import each other.
- **Reuse before adding.** Extend an existing endpoint (a new field, a filter) before adding a
  new one, and let screens share the same calls. A new endpoint is for a new action, not a copy
  of one we have.
- **Validation:** every route has Fastify schemas for its input and its responses (responses
  also stop unlisted fields from leaking).
- **Errors:** always `{ "error": { "code", "message", "details"?, "requestId" } }`. Throw
  `AppError(status, code, message)` for expected failures. Codes are in `<shared package>`.
- **Status codes:** 200 read/update · 201 created (returns the record) · 204 nothing to return ·
  400 `VALIDATION_ERROR` · 401 `UNAUTHENTICATED` · 403 `FORBIDDEN` · 404 `NOT_FOUND` · 409
  `CONFLICT` · 429 `RATE_LIMITED` · 500 `INTERNAL_ERROR` · 503 `UNAVAILABLE` when an outside
  service is off or down, and health when the database is down.
- **Pagination:** cursor-based. `?limit=50&cursor=…` → `{ "items": [...], "nextCursor": "…" | null }`.
  Default 50, max 100.
- **Auth:** deny by default. Routes need a session unless they set `config: { public: true }`.
- **Tests:** `app.inject()` against the real test database (`createTestDatabase()`), with the
  fakes of any paid service. Every project keeps its tests in its own `test/` folder, in the same
  subfolders as `src/`; `src/` holds only application code.
- **Client headers:** apps send `x-client-app` (the client app names in `stack.md`),
  `x-client-version` and `x-device-id`; available as `request.client`.
- **Formats:** money as integers, timestamps as ISO 8601 UTC strings, calendar days as
  `YYYY-MM-DD`.
- **No backward compatibility by default:** a server change may drop what older clients use;
  keep something working for them only when the owner asks for it for that feature.
- **Secrets** live only in the server's env file (`stack.md`).
- **Limits** the server enforces (how many a day, wrong guesses…) live together in
  `apps/server/src/limits.ts`, not in the env file: they are product rules.

## App (React and React Native)

- Routes and pages stay thin: they compose components and call feature hooks.
- `src/components/` is the UI kit: one component per file, PascalCase, no API calls.
- `src/features/<feature>/` holds what one feature needs: API calls (`<feature>.api.ts`), hooks
  (`useSomething.ts`) and components only that feature uses.
- `src/lib/` holds app-wide plumbing: the API client, config, the device id.
- **Styling:** values come from the theme or tokens only; no raw colours, sizes or font weights.
- **State:** React's own tools (Context + `useReducer`, `useState`), no state library.
- **Config:** the app's `.env` holds only public values, never secrets.
- **Feature switches:** a feature we aren't sure of yet ships behind a line in `FEATURES` in
  `<shared package>`; `false` hides it for a release. The app and the server read the same list,
  but each build bakes in its own value: a server check never assumes the app agrees.
