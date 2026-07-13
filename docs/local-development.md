# Local development

## Prefer host tools

Use local Python, Node, Bash, and Docker CLI already on the machine. Prefer editing and running tests on the host; use Compose for dependent services (Mongo, MySQL).

## Required tools (CI parity)

Local `scripts/validate.sh` must match GitHub Actions. Required on the host:

| Tool | Purpose |
|------|---------|
| `pre-commit` | Formatters + YAML/merge checks |
| `shellcheck` | Shell script lint (required — not skipped) |
| `python3` | Helper scripts |

Install shellcheck without root:

```bash
bash scripts/ensure-shellcheck.sh
# ensure ~/.local/bin is on PATH
```

`bootstrap.sh` calls `ensure-shellcheck.sh` automatically.

## Bootstrap (once)

```bash
bash scripts/bootstrap.sh
```

Installs git hooks (`core.hooksPath=.githooks`), pre-commit environments, and shellcheck. After this, validation runs on commit/push automatically.

## Environment

```bash
cp .env.example .env
# edit .env — never commit it
```

## Compose (dependencies)

```bash
cp docker/compose.example.yml docker-compose.yml   # or symlink / adapt
docker compose up -d mongo mysql
```

See [docker-microservices.md](docker-microservices.md).

## Dev Container / Codespaces

`.devcontainer/devcontainer.json` runs `bash scripts/bootstrap.sh --ci` on create.

## Manual validation (optional)

Hooks already run these. For debugging only:

```bash
bash scripts/validate.sh
make check   # if you prefer Make shortcuts
```

## Stack-specific

After choosing Python or Node, follow [stacks/INDEX.md](stacks/INDEX.md) for package managers, formatters, and how to extend `validate.sh`.
