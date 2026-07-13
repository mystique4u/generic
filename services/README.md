# services/

One subdirectory per **microservice**. Prefer this layout for Dockerized multi-service projects.

## Rules

- One responsibility per service
- Each service has its own `README.md` (purpose, ports, deps, how to run)
- Shared code goes in `../packages/`, not copy-pasted
- Add Compose entries when the service needs to run with dependencies

## Example

```text
services/
  api/
    README.md
  worker/
    README.md
```

If the project is a single process, use `../src/` instead and leave this directory empty (or delete it after bootstrap).
