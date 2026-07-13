#!/usr/bin/env bash
# Single validation entry point — used by CI, pre-commit, and pre-push hooks.
#
# Usage:
#   bash scripts/validate.sh
#   bash scripts/validate.sh --pre-push
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

PRE_PUSH=false
if [ "${1:-}" = "--pre-push" ]; then
  PRE_PUSH=true
fi

CHECKS_PASSED=0
CHECKS_FAILED=0

print_section() { echo ""; echo -e "${BLUE}━━ $1 ━━${NC}"; }
pass() { echo -e "${GREEN}  OK $1${NC}"; ((CHECKS_PASSED++)) || true; }
fail() { echo -e "${RED}  FAIL $1${NC}"; ((CHECKS_FAILED++)) || true; }
warn() { echo -e "${YELLOW}  WARN $1${NC}"; }

echo ""
echo "VALIDATION (generic) — CI parity"

if [ "$PRE_PUSH" = true ] && [ -n "${PUSH_REFS_FILE:-}" ] \
  && bash scripts/is-service-only-change.sh --pre-push 2>/dev/null; then
  echo -e "${GREEN}Service-only change detected — skipping app validation${NC}"
  exit 0
fi

print_section "1  ROOT LAYOUT"
if bash scripts/check-root-layout.sh; then
  pass "root allowlist"
else
  fail "root allowlist"
fi

print_section "2  SECRETS SCAN"
if bash scripts/check-secrets.sh "$REPO_ROOT"; then
  pass "no hardcoded secrets"
else
  fail "hardcoded secrets"
fi

print_section "3  PRE-COMMIT"
if command -v pre-commit &>/dev/null; then
  if pre-commit run --all-files; then
    pass "pre-commit run --all-files"
  else
    fail "pre-commit run --all-files"
  fi
else
  warn "pre-commit not installed — run bootstrap.sh"
  fail "pre-commit missing (required)"
fi

print_section "4  SHELLCHECK"
if command -v shellcheck &>/dev/null; then
  mapfile -t shell_files < <(
    find scripts -type f -name '*.sh' -print
    find .githooks -type f -print
    find .cursor/hooks -type f -name '*.sh' -print
  )
  if [ "${#shell_files[@]}" -eq 0 ]; then
    pass "no shell files"
  elif shellcheck -x "${shell_files[@]}"; then
    pass "shellcheck"
  else
    fail "shellcheck"
  fi
else
  warn "shellcheck not installed — skipping"
  pass "shellcheck skipped"
fi

print_section "5  VERSION + CHANGELOG"
version_args=()
if [ "$PRE_PUSH" = true ]; then
  version_args=(--pre-push)
fi
if bash scripts/check-version.sh "${version_args[@]+"${version_args[@]}"}"; then
  pass "version / changelog"
else
  fail "version / changelog"
fi

print_section "6  STACK EXTENSIONS (optional)"
if [ -f scripts/validate-stack.sh ]; then
  if bash scripts/validate-stack.sh; then
    pass "validate-stack.sh"
  else
    fail "validate-stack.sh"
  fi
else
  pass "no validate-stack.sh (meta-kit only)"
fi

echo ""
echo "SUMMARY: passed=$CHECKS_PASSED failed=$CHECKS_FAILED"
if [ "$CHECKS_FAILED" -eq 0 ]; then
  echo -e "${GREEN}ALL CHECKS PASSED${NC}"
  exit 0
fi
echo -e "${RED}VALIDATION FAILED${NC}"
exit 1
