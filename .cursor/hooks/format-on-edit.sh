#!/usr/bin/env bash
# Deterministic format of the edited file (zero model tokens).
set -euo pipefail
input=$(cat)
file=$(printf '%s' "$input" | python3 -c 'import sys,json
try:
    d=json.load(sys.stdin)
    print(d.get("file") or d.get("path") or "")
except Exception:
    print("")')

if [ -z "$file" ] || [ ! -f "$file" ]; then
  echo '{}'
  exit 0
fi

# Best-effort formatters when available
case "$file" in
  *.py)
    if command -v ruff &>/dev/null; then
      ruff format "$file" >/dev/null 2>&1 || true
      ruff check --fix "$file" >/dev/null 2>&1 || true
    fi
    ;;
  *.ts|*.tsx|*.js|*.jsx|*.json|*.css|*.md)
    if command -v npx &>/dev/null && [ -f package.json ]; then
      npx --yes prettier --write "$file" >/dev/null 2>&1 || true
    fi
    ;;
  *.yml|*.yaml|*.sh)
    # trailing whitespace / EOF handled by pre-commit on commit
    ;;
esac

echo '{}'
exit 0
