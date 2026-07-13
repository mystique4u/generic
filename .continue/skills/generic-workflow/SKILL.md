---
name: generic-workflow
description: Git branch-first workflow, automatic hooks validation, and GitOps parity with CI. Use when committing, pushing, opening PRs, or setting up a new clone.
---

# generic-workflow

## Branch first

```bash
git checkout main && git pull
git checkout -b feature/short-description
```

Never implement on `main`.

## Automation

After `bash scripts/bootstrap.sh`:

| Action | Automatic check |
|--------|-----------------|
| commit | `scripts/validate.sh` + Conventional Commits |
| push | `scripts/validate.sh --pre-push` |
| merge to main | release-please Release PR |

Do not ask the user to run validate/bump scripts manually.

## Docs in the same PR

CHANGELOG `[Unreleased]`, and `docs/INDEX.md` when docs change.
