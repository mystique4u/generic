# Using this template

## Prefer: Use this template

1. Enable **Template repository** on the `generic` GitHub repo (Settings).
2. Click **Use this template** → create a new repository for your idea.
3. Clone → `bash scripts/bootstrap.sh`.
4. Add code under `services/` / `apps/` (or `src/` for a single process).
5. Follow a [stack recipe](stacks/INDEX.md).

New repos get a clean history and are **not** linked as forks of `generic`.

## When to fork

Fork only to **contribute changes back** to the template (PR to `generic`).

## When you already have code

1. Create a new repo from this template.
2. Move existing code into `services/`, `apps/`, `packages/`, or `src/`.
3. Extend `scripts/validate.sh` per the stack recipe.
4. Do not try to “merge the template into” an old messy tree as the primary approach.

## Do not build products inside `generic`

Keep `generic` as the shared meta-kit. Each product idea = its own repository from the template.
