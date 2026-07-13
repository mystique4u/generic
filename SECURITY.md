# Security Policy

## Supported versions

Security fixes apply to the latest release on `main` and the current template version in `VERSION`.

## Reporting a vulnerability

Do **not** open a public issue for security problems.

1. Email or message the repository maintainers privately with:
   - Description of the issue
   - Steps to reproduce
   - Impact assessment (if known)
2. Allow reasonable time for a fix before public disclosure.

## Local and CI scanning

This template runs secret scanning and dependency checks locally (via git hooks) and in CI.
See [docs/security.md](docs/security.md).

## Secrets

Never commit API keys, passwords, tokens, or private keys.
Use `.env` (gitignored) and document required variables in `.env.example`.
