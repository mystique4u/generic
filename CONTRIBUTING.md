# Contributing

## One-time setup

```bash
bash scripts/bootstrap.sh
```

This sets `core.hooksPath=.githooks`, installs pre-commit hook environments, and optionally recommended skills.

Optional: copy `.env.example` → `.env`.

## Branch workflow

1. Start from up-to-date `main`
2. Create `feature/...` or `fix/...`
3. Keep changes focused; update docs/CHANGELOG in the same PR
4. Push — pre-push hook runs the same checks as CI

Never commit directly to `main`.

## Commits

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`, `ci:`

These feed **release-please** for SemVer and CHANGELOG automation.

## Validation

You should not need to run this manually — hooks and CI do:

```bash
bash scripts/validate.sh
bash scripts/validate.sh --pre-push
```

## Cleanliness

Follow [docs/cleanliness-and-organization.md](docs/cleanliness-and-organization.md). Leave the tree cleaner than you found it.

## English only

All repository content (code, comments, docs, commits) must be English.

## Pull requests

- One logical change per PR
- Link related issues
- Note stack recipe followed (Python / Node) when adding app code
- Confirm hooks passed locally (automatic if bootstrap was run)
