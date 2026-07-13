#!/usr/bin/env bash
# Inject binding agent context at session start; self-heal git hooksPath.
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
if [ -d "$REPO_ROOT/.githooks" ]; then
  current="$(git -C "$REPO_ROOT" config --get core.hooksPath 2>/dev/null || true)"
  if [ "$current" != ".githooks" ]; then
    git -C "$REPO_ROOT" config core.hooksPath .githooks || true
  fi
fi

python3 - <<'PY'
import json
print(json.dumps({
  "additional_context": (
    "BINDING FLOWS (non-negotiable): Read AGENTS.md first. "
    "Branch before implementing (feature/... or fix/...). Never commit on main. "
    "Never --no-verify. Hooks run validate.sh = CI. "
    "Cleanliness is mandatory (docs/cleanliness-and-organization.md). "
    "English only in repo files. release-please owns SemVer. "
    "Cursor hook enforce-git-flow.sh + git hooks block shortcuts — do not work around them. "
    "Skills: generic-project, generic-workflow, generic-versioning, generic-cleanliness, "
    "generic-language, generic-tdd, generic-docker; token saving: caveman suite."
  )
}))
PY
exit 0
