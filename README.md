# generic

AI-assisted project **meta-kit** template. Use it as the baseline for new projects — agent entrypoints, skills, rules, hooks, SemVer/GitOps automation, Docker placeholders, and modular docs. No sample application code.

## Quick start (new project)

1. On GitHub: open this repo → **Use this template** → create a new repository.
2. Clone the new repo.
3. Run once:

```bash
bash scripts/bootstrap.sh
# non-interactive (Codespaces / CI):
# bash scripts/bootstrap.sh --ci --name my-project --with-recommended-skills
```

4. Pick a stack recipe under [docs/stacks/](docs/stacks/INDEX.md) and put code in `services/` / `apps/` (or `src/` for a single-app layout).
5. Work on a feature branch. Hooks + CI + release-please handle validation and versioning — you should not run those scripts by hand.

See [docs/using-the-template.md](docs/using-the-template.md).

## What you get

| Area | Contents |
|------|----------|
| Agent OS | `AGENTS.md`, `.agents/skills/`, `.cursor/rules`, hooks, subagents |
| Automation | git hooks = CI, release-please, Dependabot, security workflow |
| Layout | Empty `services/`, `apps/`, `packages/`, `tests/`, `src/` placeholders |
| Docs | Modular entrypoints under [docs/INDEX.md](docs/INDEX.md) |
| Localdev | Host tools preferred; Compose example for Mongo/MySQL |

## Enable as GitHub Template

1. Open the repository on GitHub → **Settings**
2. Check **Template repository**
3. For each new idea: **Use this template** → create a new repo → clone → `bash scripts/bootstrap.sh`

Do **not** fork this repo to start a product — fork only when contributing back to the template itself.

## Documentation

Start at [docs/INDEX.md](docs/INDEX.md). Agents start at [AGENTS.md](AGENTS.md).

## License

MIT — see [LICENSE](LICENSE).
