# apps/

Frontends, CLIs, and BFF processes that are not backend microservices.

## Rules

- One app per subdirectory with its own README
- Talk to backends via documented APIs; do not import service internals
- Shared UI/utils that multiple apps need → `../packages/`

## Example

```text
apps/
  web/
    README.md
  cli/
    README.md
```
