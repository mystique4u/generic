---
name: generic-project
description: Explains repository layout, separation of responsibilities, libraries-first, and the cleanliness contract. Use when scaffolding services, choosing where code goes, or reviewing structure.
---

# generic-project

## Layout

- Prefer `services/` + `apps/` for microservices
- Use `src/` only for a single-process project (not both long-term)
- Shared code → `packages/`
- Integration tests → `tests/`

## Rules

1. One responsibility per module/service
2. Thin entrypoints
3. Prefer maintained libraries/frameworks
4. Follow [docs/cleanliness-and-organization.md](../../../docs/cleanliness-and-organization.md)
5. English only

## Stacks

See [docs/stacks/INDEX.md](../../../docs/stacks/INDEX.md).
