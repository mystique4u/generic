# GitOps and SemVer

## Branch first

Never implement on `main`. Create `feature/...` or `fix/...` from an updated `main`.

## Hooks equal CI

| Event | What runs |
|-------|-----------|
| commit | `scripts/validate.sh` + Conventional Commit message check |
| push | `scripts/validate.sh --pre-push` |
| GitHub Actions | same `scripts/validate.sh` |

Do not invent a second check path.

## Conventional Commits

Required. Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`, `perf`, `build`.

Breaking changes: `feat!:` or `BREAKING CHANGE:` footer → major bump via release-please.

## release-please (primary versioning)

On merge to `main`, [release-please](https://github.com/googleapis/release-please) opens/updates a **Release PR** that bumps `VERSION`, updates `CHANGELOG.md`, and then tags + creates a GitHub Release when that PR merges.

**Repo setting required:** Settings → Actions → General → Workflow permissions → enable **Allow GitHub Actions to create and approve pull requests**. Without this, the release-please job fails when creating the Release PR.

Use Conventional Commits so bumps are correct (`feat` → minor, `fix` → patch, `BREAKING CHANGE` → major).

## Offline fallback

`scripts/bump-version.sh` exists for air-gapped / emergency use only. Prefer release-please.

## Service paths

Changes limited to paths in `scripts/service-paths.list` skip app-oriented pre-push gates (meta-kit / docs / agent config).

## CHANGELOG

Keep [Keep a Changelog](https://keepachangelog.com/) format. Behaviour changes go under `[Unreleased]` until release-please promotes them.
