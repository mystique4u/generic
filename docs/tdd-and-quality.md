# TDD and quality

## Test-driven development

When adding or changing behaviour:

1. **Red** — write a failing test that describes the behaviour
2. **Green** — implement the minimum to pass
3. **Refactor** — clean up while tests stay green

Prefer the community skill `test-driven-development` when installed.

## Where tests live

| Kind | Location |
|------|----------|
| Unit | Next to code (`services/<name>/tests/` or package-local) |
| Integration | `tests/` at repo root |
| Contract / API | Prefer dedicated tests under the owning service |

## Quality bar

- Readable by humans; clear names
- One responsibility per module/service
- Prefer libraries/frameworks over custom wheels
- No dead code in the PR
- See [cleanliness-and-organization.md](cleanliness-and-organization.md)

## Automation

Formatters and tests run via git hooks and CI — do not skip hooks (`--no-verify`) unless explicitly required and justified.
