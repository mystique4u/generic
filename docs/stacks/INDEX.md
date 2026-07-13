# Stack recipes

Choose one primary stack per project (you can mix later, but start simple).

| Recipe | When |
|--------|------|
| [python-mongo-mysql.md](python-mongo-mysql.md) | Python APIs / workers with Mongo and/or MySQL |
| [node-tailwind.md](node-tailwind.md) | Node services or modern UI with Tailwind |

After choosing:

1. Put code in `services/` / `apps/` (or `src/` for a single process).
2. Extend `scripts/validate.sh` with that stack’s lint/test/audit commands.
3. Prefer host package managers (`uv` / `npm` / `pnpm`) already on the machine.
