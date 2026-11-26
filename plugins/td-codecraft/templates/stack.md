# Stack

What this project is built with, and every tech decision with its reason. Written by
`/td-codecraft:init`, kept current by `/td-codecraft:decide`, read by `/td-codecraft:code-rules`.
A change of mind is a new decision, not an edit.

## Stack

| Part             | Choice                                                               |
| ---------------- | -------------------------------------------------------------------- |
| Language         | e.g. TypeScript, not strict                                          |
| Runtime          | e.g. Node.js 24, runs TypeScript directly (`.ts` imports)            |
| Repository       | e.g. npm workspaces: `apps/server`, `apps/mobile`, `packages/shared` |
| Shared package   | e.g. `@app/shared`: types and pure logic for the app and the server  |
| Database         | e.g. PostgreSQL 16; migrations in `apps/server/db/migrations/`       |
| API              | e.g. Fastify, REST under `/v1`                                       |
| App              | e.g. Expo (React Native), or React with Vite                         |
| Tests            | e.g. `node:test`; `app.inject()` against a test database             |
| Format and lint  | e.g. Prettier and ESLint, from the repository root                   |
| Hosting          | e.g. Neon (database), Cloud Run (server), or `none` yet              |
| Outside services | e.g. email, payments, messaging, each with its fake                  |

## Conventions

| What                  | Value                                     |
| --------------------- | ----------------------------------------- |
| Owner column          | e.g. `business_id` or `owner_id`          |
| Money                 | e.g. integer paise in `*_paise` columns   |
| Time zone for "today" | e.g. `Asia/Kolkata`                       |
| Phone numbers         | e.g. E.164 text                           |
| Server secrets        | e.g. `apps/server/.env`                   |
| Client app names      | e.g. `app-android`, `app-ios`, `app-web`  |

## Approved libraries

| Library | Where | Why | Decided |
| ------- | ----- | --- | ------- |

## Decisions

Newest last. A replaced decision stays, marked "replaced by D<n>".

| ID  | Date | Decision | Why | Replaces |
| --- | ---- | -------- | --- | -------- |
