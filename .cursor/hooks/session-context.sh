#!/usr/bin/env bash
# Inject agent context at session start; self-heal git hooksPath.
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
if [ -d "$REPO_ROOT/.githooks" ]; then
  current="$(git -C "$REPO_ROOT" config --get core.hooksPath 2>/dev/null || true)"
  if [ "$current" != ".githooks" ]; then
    git -C "$REPO_ROOT" config core.hooksPath .githooks || true
  fi
fi

echo '{
  "additional_context": "generic meta-kit — read AGENTS.md first. Cleanliness is mandatory (docs/cleanliness-and-organization.md). ENGLISH ONLY in repo files. Prefer services/+apps/. Hooks run validate.sh on commit/push after bootstrap. Skills: generic-project, generic-workflow, generic-versioning, generic-cleanliness, generic-language, generic-tdd, generic-docker. Token saving: caveman suite. Releases: release-please (not manual bumps)."
}'
exit 0
