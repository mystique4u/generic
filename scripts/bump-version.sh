#!/usr/bin/env bash
# Offline SemVer bump fallback (prefer release-please in normal flow).
#
# Usage:
#   bash scripts/bump-version.sh [patch|minor|major|auto]
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

BUMP_TYPE="${1:-auto}"

detect_bump_from_commits() {
  local last_tag range commits
  last_tag="$(git describe --tags --abbrev=0 --match 'v*' 2>/dev/null || echo '')"
  if [ -n "$last_tag" ]; then
    range="${last_tag}..HEAD"
  else
    range="HEAD"
  fi
  commits="$(git log "$range" --pretty=format:'%s' 2>/dev/null || true)"
  if [ -z "$commits" ]; then
    echo "patch"
    return
  fi
  if echo "$commits" | grep -qE '(^|:)![:\)]|BREAKING CHANGE'; then
    echo "major"
  elif echo "$commits" | grep -qE '^feat(\(.+\))?:'; then
    echo "minor"
  else
    echo "patch"
  fi
}

if [ "$BUMP_TYPE" = "auto" ]; then
  BUMP_TYPE="$(detect_bump_from_commits)"
  echo "Auto-detected bump type: $BUMP_TYPE"
fi

case "$BUMP_TYPE" in
  patch|minor|major) ;;
  *)
    echo "Usage: bash scripts/bump-version.sh [patch|minor|major|auto]" >&2
    exit 1
    ;;
esac

python3 - "$BUMP_TYPE" <<'PY'
import sys
from pathlib import Path

bump = sys.argv[1]
path = Path("VERSION")
raw = path.read_text(encoding="utf-8").strip()
major, minor, patch = map(int, raw.split("."))
if bump == "major":
    major, minor, patch = major + 1, 0, 0
elif bump == "minor":
    minor, patch = minor + 1, 0
else:
    patch += 1
new = f"{major}.{minor}.{patch}"
path.write_text(new + "\n", encoding="utf-8")
print(f"Bumped VERSION → {new}")
print("Prefer release-please for normal releases. Update CHANGELOG if needed.")
PY
