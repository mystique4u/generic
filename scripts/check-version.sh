#!/usr/bin/env bash
# Validate VERSION file (SemVer) and CHANGELOG presence.
# Offline / emergency companion to release-please.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

PRE_PUSH=false
if [ "${1:-}" = "--pre-push" ]; then
  PRE_PUSH=true
fi

ERRORS=0
fail() { echo "  FAIL $1"; ((ERRORS++)) || true; }
pass() { echo "  OK $1"; }

if [ ! -f VERSION ]; then
  fail "VERSION file missing"
else
  VER="$(tr -d '[:space:]' < VERSION)"
  if [[ "$VER" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    pass "VERSION=$VER"
  else
    fail "VERSION '$VER' is not SemVer X.Y.Z"
  fi
fi

if [ -f CHANGELOG.md ]; then
  if grep -q '## \[Unreleased\]' CHANGELOG.md; then
    pass "CHANGELOG.md has [Unreleased]"
  else
    fail "CHANGELOG.md missing ## [Unreleased]"
  fi
else
  fail "CHANGELOG.md missing"
fi

# release-please is primary; on push to main with app code, only warn if VERSION
# matches latest tag (release PR may still be pending). Soft check.
if [ "$PRE_PUSH" = true ]; then
  PUSHING_TO_MAIN=false
  if [ -n "${PUSH_REFS_FILE:-}" ] && [ -f "$PUSH_REFS_FILE" ]; then
    while read -r _local_ref _local_sha remote_ref _remote_sha; do
      if [[ "${remote_ref:-}" == "refs/heads/main" ]]; then
        PUSHING_TO_MAIN=true
      fi
    done < "$PUSH_REFS_FILE"
  fi
  if [ "$PUSHING_TO_MAIN" = true ]; then
    if bash scripts/is-service-only-change.sh --pre-push 2>/dev/null; then
      pass "service-only push to main"
    else
      pass "app push to main — release-please will open/update Release PR"
    fi
  fi
fi

if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi
exit 0
