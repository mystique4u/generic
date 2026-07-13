# packages/

Shared libraries used by multiple `services/` or `apps/`.

## Rules

- No business-entrypoints here (no “main” servers)
- Version and test packages independently when possible
- Prefer extracting a package only when duplication is real

Keep empty until a shared package is needed.
