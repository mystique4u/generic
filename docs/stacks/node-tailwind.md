# Recipe: Node + modern UI + Tailwind

## Prefer

- Current LTS Node; package manager already on the host (`npm`, `pnpm`, or `yarn`)
- Modern UI framework your team knows (e.g. React/Next, Vue, Svelte) — **libraries first**
- [Tailwind CSS](https://tailwindcss.com/) for styling
- Tests: Vitest / Playwright as needed; lint: ESLint; format: Prettier
- Layout: `apps/<web-name>/` for UI; `services/<api-name>/` for Node APIs

## Suggested app layout

```text
apps/web/
  README.md
  package.json
  src/
  Dockerfile          # when containerizing
```

## Localdev

```bash
cd apps/web && npm install && npm run dev
docker compose up -d mongo mysql   # if the app needs them
```

## Extend validate.sh

```bash
# from repo root, or per-package
npm run lint
npm test
npm audit --audit-level=high || true
```

Keep commands inside `scripts/validate.sh` so hooks and CI stay identical.

## npm publish projects only

If this repo publishes packages to npm, you may document **semantic-release** as an alternative. Default template releases stay on **release-please**.

## Optional community skills

- `web-development`, `web-testing`, `frontend-design`
- `performance` (addyosmani/agent-skills)
