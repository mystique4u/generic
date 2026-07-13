#!/usr/bin/env bash
# Scan for hardcoded secrets (used by validate.sh / CI).
set -euo pipefail
ROOT="${1:-.}"
cd "$ROOT"
echo "Scanning for hardcoded secrets..."
if grep -r -i -E "(password|secret|api_key|token).*=.*['\"][^'\"]{8,}['\"]" \
  --exclude="*.example" --exclude="README.md" --exclude="CHANGELOG.md" \
  --exclude="CONTRIBUTING.md" --exclude="AGENTS.md" --exclude="SECURITY.md" \
  --exclude="SKILL.md" --exclude="*.md" \
  --exclude-dir=".git" --exclude-dir=".venv" --exclude-dir="node_modules" \
  --exclude-dir=".pytest_cache" --exclude-dir=".agents" --exclude-dir=".continue" \
  --exclude-dir=".cursor" \
  . 2>/dev/null \
  | grep -v "^[[:space:]]*#" \
  | grep -v "os.environ.get" \
  | grep -v "os.getenv" \
  | grep -v "process.env" \
  | grep -v "gitleaks:allow"; then
  echo "::error::Found potential hardcoded secrets!" >&2
  exit 1
fi
echo "No hardcoded secrets detected"
