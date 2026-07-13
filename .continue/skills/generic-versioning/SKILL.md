---
name: generic-versioning
description: SemVer via release-please, CHANGELOG Keep a Changelog format, and offline bump-version fallback. Use when releasing, tagging, or editing VERSION/CHANGELOG.
---

# generic-versioning

## Primary: release-please

Merges to `main` open/update a Release PR that bumps `VERSION`, updates `CHANGELOG.md`, tags, and creates a GitHub Release.

Use Conventional Commits so bumps are correct (`feat` → minor, `fix` → patch, `BREAKING CHANGE` → major).

## Source of truth

- `VERSION` file (X.Y.Z)
- `CHANGELOG.md` with `[Unreleased]`

## Offline fallback only

```bash
bash scripts/bump-version.sh [patch|minor|major|auto]
```

Prefer release-please in normal flow.
