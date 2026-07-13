# Recipe: Python + Mongo / MySQL

## Prefer

- [uv](https://github.com/astral-sh/uv) + `pyproject.toml` (or Poetry if already standard on the team)
- FastAPI (or Flask/Django when justified) — **libraries first**
- Drivers: Motor/PyMongo for Mongo; SQLAlchemy or official connectors for MySQL
- Tests: `pytest`; lint/format: `ruff`; types: `mypy` optional
- Layout: `services/<api-name>/` with clear package boundary

## Suggested service layout

```text
services/api/
  README.md
  pyproject.toml
  src/...
  tests/
  Dockerfile          # when containerizing
```

## Localdev

```bash
# deps
uv sync   # or pip install -e ".[dev]"

# databases via Compose
docker compose up -d mongo mysql
```

Wire connection strings from `.env` (see `.env.example`).

## Extend validate.sh

Add steps when Python code exists:

```bash
ruff check services apps packages
ruff format --check services apps packages
pytest
pip-audit || true   # harden to fail when ready
```

Register the same commands in CI by keeping them inside `scripts/validate.sh`.

## Optional community skills

- `backend-development` (rubencr14/agent-skills)
- `security-and-hardening`, `test-driven-development` (already in bootstrap defaults)
