# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.0.0 (2026-07-13)


### Features

* add AI-assisted project meta-kit template ([46e42d9](https://github.com/mystique4u/generic/commit/46e42d91a8f5d1535f0e5adf5cb6fa9b54a9087c))


### Bug Fixes

* quiet Dependabot for meta-kit without app manifests ([4d76b2c](https://github.com/mystique4u/generic/commit/4d76b2c97eb0525c4bd6ea0e5f61b1c02278c51e))
* require shellcheck locally for CI parity ([32a6202](https://github.com/mystique4u/generic/commit/32a6202ab9b123796293c03dd29c7c62950cb242))
* use valid trivy-action v0.36.0 tag ([feba857](https://github.com/mystique4u/generic/commit/feba8578f1cc899db097fe6f7295667b5099fca3))

## [Unreleased]

### Fixed

- ShellCheck SC2034 in `get-push-changed-files.sh`; local validate now requires shellcheck (CI parity) via `scripts/ensure-shellcheck.sh`
- Dependabot: drop pip/npm ecosystems until manifests exist (meta-kit); bump workflow action versions on main and close noisy PRs

### Added

- Initial AI-assisted project meta-kit template (agent OS, hooks, docs, Docker placeholders, CI automation)
