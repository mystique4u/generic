# Docker and microservices

## Defaults

- Prefer **one responsibility per service** under `services/<name>/`.
- Frontends / CLIs under `apps/`.
- Shared code under `packages/`.
- Day-to-day coding on the **host**; Compose for dependencies and integration.

## Example Compose

[`docker/compose.example.yml`](../docker/compose.example.yml) defines placeholder `app`, `mongo`, and `mysql` services. Copy/adapt — not production-ready.

```bash
cp docker/compose.example.yml docker-compose.yml
cp .env.example .env
docker compose up -d
```

## Adding a service

1. Create `services/<name>/` with its own README, Dockerfile (when needed), and tests.
2. Add a Compose service with a clear name, healthcheck when useful, and env from `.env`.
3. Document ports and dependencies in that service README and in this doc if cross-cutting.
4. Extend `scripts/validate.sh` for that service’s lint/test commands.

## Networks and volumes

- Use a single user-defined network for localdev.
- Named volumes for database data; never commit volume data.

## Images

Scan images in CI (Trivy) when you add real Dockerfiles. Keep base images pinned by digest or minor tag.
