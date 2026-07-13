# Security

## Local (automatic via hooks)

- `scripts/check-secrets.sh` — pattern scan for hardcoded secrets
- pre-commit hooks — large files, YAML/TOML sanity, formatters

## Scheduled / CI

- `.github/workflows/security.yml` — gitleaks, dependency audit, Trivy (when Dockerfiles exist)
- Dependabot — **GitHub Actions only** in this meta-kit (no pip/npm until you add manifests)

When you adopt a [stack recipe](stacks/INDEX.md), re-add pip and/or npm ecosystems to `.github/dependabot.yml` pointing at the directories that contain `pyproject.toml` / `package.json`.

## Stack extensions

| Stack | Local tools |
|-------|-------------|
| Python | `pip-audit` / `uv` audit when available |
| Node | `npm audit` / `pnpm audit` |

Wire these into `scripts/validate.sh` when you adopt a stack recipe.

## Rules of thumb

- Secrets only in `.env` or a secret manager
- No credentials in Compose files committed to git (use env substitution)
- Report vulnerabilities per [SECURITY.md](../SECURITY.md)
