---
name: generic-docker
description: Dockerized microservices conventions, Compose localdev, and host-first development. Use when adding services, Dockerfiles, or local dependencies.
---

# generic-docker

## Defaults

- One responsibility per `services/<name>/`
- Host tools for day-to-day; Compose for Mongo/MySQL/etc.
- Start from `docker/compose.example.yml`

See [docs/docker-microservices.md](../../../docs/docker-microservices.md).

## Adding a service

1. Create `services/<name>/` + README
2. Add Compose service + env via `.env`
3. Extend `scripts/validate.sh` (or `scripts/validate-stack.sh`) for lint/tests
