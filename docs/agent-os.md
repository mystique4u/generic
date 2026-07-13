# Agent OS

Skills, rules, hooks, subagents, MCP, and plugins for this template.

## Entrypoints

- Agents: [AGENTS.md](../AGENTS.md)
- Docs: [INDEX.md](INDEX.md)

## Skills (`.agents/skills/`)

Project skills (always present):

| Skill | Role |
|-------|------|
| `generic-project` | Layout, SoC, libraries-first |
| `generic-workflow` | Branch / hooks / GitOps |
| `generic-versioning` | SemVer / release-please |
| `generic-language` | English-only |
| `generic-tdd` | Test-first |
| `generic-docker` | Microservices + Compose |
| `generic-cleanliness` | Tidy repo checklist |
| `caveman*` / `cavecrew` | Token efficiency |

Continue mirrors live under `.continue/skills/` for caveman (and can mirror project skills).

### Recommended community skills

Installed by `bootstrap.sh --with-recommended-skills` via the [skills CLI](https://github.com/vercel-labs/skills):

| Skill | Source |
|-------|--------|
| `test-driven-development` | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) |
| `security-and-hardening` | addyosmani/agent-skills |
| `planning-and-task-breakdown` | addyosmani/agent-skills |
| `skill-creator` | [anthropics/skills](https://github.com/anthropics/skills) |
| `suggesting-cursor-hooks` | [spencerpauly/awesome-cursor-skills](https://github.com/spencerpauly/awesome-cursor-skills) |

Code review: use `.cursor/agents/code-reviewer.md` and `caveman-review` (vendored).

Opt-in (stack recipes / as needed):

- `performance` (addyosmani)
- `backend-development`, `web-development`, `web-testing`, `cybersecurity` ([rubencr14/agent-skills](https://github.com/rubencr14/agent-skills))
- `frontend-design`, `mcp-builder` (anthropics)
- `suggesting-cursor-rules`, `suggesting-skills` (spencerpauly)

### Discovery registries

- [skills.sh](https://skills.sh)
- [claude-plugins.dev](https://claude-plugins.dev)
- [cursor.directory](https://cursor.directory)
- [PatrickJS/awesome-cursorrules](https://github.com/PatrickJS/awesome-cursorrules)

Pin installs in `skills-lock.json` when the CLI writes one.

## Enforcement

Docs and skills are guidance. **Enforcement** is layered so agents cannot casually bypass flows:

| Layer | What | Can model ignore? |
|-------|------|-------------------|
| Cursor `beforeShellExecution` + `failClosed` | `enforce-git-flow.sh` — deny commit on `main`, deny `--no-verify`, ask/deny force-push | No (deterministic) |
| Git hooks (`.githooks`) | `validate.sh` on commit/push; Conventional Commits | No (unless user forces outside Cursor) |
| Always-on rules | `generic-binding-flow`, `generic-core`, `generic-cleanliness` | Soft — but binding language + sessionStart context |
| Skills / docs | Procedures and checklists | Soft — use for how-to |

If an agent tries to skip validation or work on `main`, the shell hook should block it. Prefer fixing the failure over disabling hooks.

## Rules (`.cursor/rules/`)

| Rule | Apply |
|------|-------|
| `generic-binding-flow.mdc` | always — MUST/NEVER workflow; no rationalization |
| `generic-core.mdc` | always — AGENTS, branch, secrets, hooks |
| `generic-cleanliness.mdc` | always — tidy layout |
| `generic-docs.mdc` | `docs/**` — modular docs |

## Hooks (`.cursor/hooks.json`)

| Event | Behaviour |
|-------|-----------|
| `sessionStart` | Binding context + self-heal `core.hooksPath` |
| `beforeShellExecution` (`git`) | **failClosed** enforce-git-flow (block shortcuts) |
| `afterFileEdit` | Auto-format edited file |

## Subagents (`.cursor/agents/`)

- `code-reviewer.md` — cleanliness, SoC, security
- `debugger.md` — evidence-first debugging

## MCP

- Commit only `.cursor/mcp.json.example` (no secrets).
- Copy to `.cursor/mcp.json` and use `${env:TOKEN}` interpolation.
- User-level MCP stays in `~/.cursor/mcp.json`.
- Cursor Automations need dashboard MCP, not only project mcp.json.

## Plugins

Do not commit a `plugins/` tree. Document Marketplace recommendations in AGENTS.md; install per machine/team.
