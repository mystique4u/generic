# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- ShellCheck SC2034 in `get-push-changed-files.sh`; local validate now requires shellcheck (CI parity) via `scripts/ensure-shellcheck.sh`
- Dependabot: drop pip/npm ecosystems until manifests exist (meta-kit); bump workflow action versions on main and close noisy PRs

### Added

- Binding flow rule + `enforce-git-flow.sh` Cursor hook (`failClosed`) so agents cannot skip branch-first / hooks
- Initial AI-assisted project meta-kit template (agent OS, hooks, docs, Docker placeholders, CI automation)
