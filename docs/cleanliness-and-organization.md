# Cleanliness and organization

Mandatory contract for humans and agents. Also enforced via `.cursor/rules/generic-cleanliness.mdc` and `.agents/skills/generic-cleanliness/`.

## Principles

1. **Thin root** — only entrypoints and config at the repository root (README, AGENTS, VERSION, etc.). No orphan notes, scratch files, or one-off scripts at root.
2. **One purpose per directory** — every top-level folder has a short README stating ownership.
3. **Separation of responsibilities** — a module/service does one job; thin entrypoints.
4. **Libraries first** — prefer maintained libraries/frameworks over reinventing.
5. **Readable by humans** — clear names, small focused files, English-only content.
6. **Leave it cleaner** — every PR should prune dead code, unused placeholders, and stale docs.

## Layout ownership

| Path | Owns |
|------|------|
| `services/` | Backend microservices (preferred for multi-service projects) |
| `apps/` | Frontends, CLIs, BFF |
| `packages/` | Shared libraries used by multiple services/apps |
| `tests/` | Integration / cross-service tests |
| `src/` | Single-app layout — use **or** `services/`, not both long-term |
| `scripts/` | Automation invoked by hooks/CI (not ad-hoc tools) |
| `docs/` | Modular documentation with [INDEX.md](INDEX.md) |
| `.agents/`, `.cursor/` | Agent meta only — never application packages |

## Root allowlist

Unexpected top-level names should not accumulate. Known roots are listed in `scripts/root-allowlist.txt` and checked by `scripts/validate.sh`.

## Docs hygiene

- New doc → add a row to [INDEX.md](INDEX.md)
- No duplicate guides; link to the canonical page
- Update CHANGELOG `[Unreleased]` for behaviour changes

## PR checklist

- [ ] No unused placeholder dirs left without reason (or README explains why)
- [ ] No dead code, commented-out blocks, or orphan files
- [ ] Docs INDEX updated if docs changed
- [ ] CHANGELOG updated if behaviour changed
- [ ] Secrets not committed; `.env` stays local
- [ ] English only in repo files
