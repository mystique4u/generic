# src/

Optional **single-app** layout. Use this **or** `services/` for application code — not both long-term.

- Multi-service / microservices → prefer `../services/` (+ `../apps/`) and delete or ignore `src/`
- Single process library/CLI/API → put code here and leave `services/` empty

See [docs/cleanliness-and-organization.md](../docs/cleanliness-and-organization.md).
