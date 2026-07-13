#!/usr/bin/env bash
# One-command project bootstrap. Idempotent.
#
# Usage:
#   bash scripts/bootstrap.sh
#   bash scripts/bootstrap.sh --ci --name my-project [--version 0.1.0] [--with-recommended-skills]
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

CI_MODE=false
WITH_SKILLS=false
PROJECT_NAME=""
PROJECT_VERSION="0.1.0"

while [ $# -gt 0 ]; do
  case "$1" in
    --ci) CI_MODE=true; shift ;;
    --with-recommended-skills) WITH_SKILLS=true; shift ;;
    --name) PROJECT_NAME="${2:-}"; shift 2 ;;
    --version) PROJECT_VERSION="${2:-}"; shift 2 ;;
    -h|--help)
      echo "Usage: bash scripts/bootstrap.sh [--ci] [--name NAME] [--version X.Y.Z] [--with-recommended-skills]"
      exit 0
      ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

if [ -z "$PROJECT_NAME" ]; then
  if [ "$CI_MODE" = true ]; then
    PROJECT_NAME="$(basename "$REPO_ROOT")"
  else
    read -r -p "Project name [${PWD##*/}]: " PROJECT_NAME
    PROJECT_NAME="${PROJECT_NAME:-${PWD##*/}}"
  fi
fi

if [ "$CI_MODE" = false ] && [ -z "${PROJECT_VERSION}" ]; then
  read -r -p "Initial version [0.1.0]: " PROJECT_VERSION
  PROJECT_VERSION="${PROJECT_VERSION:-0.1.0}"
fi

echo "Bootstrapping project='$PROJECT_NAME' version='$PROJECT_VERSION'"

# Write VERSION
echo "$PROJECT_VERSION" > VERSION

# Light placeholder rename in key docs (generic → project name) when not staying as template
if [ "$PROJECT_NAME" != "generic" ]; then
  for f in README.md AGENTS.md CONTRIBUTING.md; do
    if [ -f "$f" ]; then
      # Only replace title/brand mentions carefully
      sed -i "s/# generic/# ${PROJECT_NAME}/g; s/Generic — Agent/# ${PROJECT_NAME} — Agent/g; s/\*\*generic\*\*/**${PROJECT_NAME}**/g" "$f" || true
    fi
  done
fi

# Git hooks via committed .githooks (do not use `pre-commit install` — conflicts with hooksPath)
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit .githooks/pre-push .githooks/commit-msg 2>/dev/null || true
chmod +x scripts/*.sh .cursor/hooks/*.sh 2>/dev/null || true

echo "git core.hooksPath → .githooks"

# Install pre-commit hook environments (used by validate.sh / commit-msg)
if command -v pipx &>/dev/null; then
  pipx ensurepath >/dev/null 2>&1 || true
fi
if command -v pre-commit &>/dev/null; then
  pre-commit install-hooks || true
  echo "pre-commit hook environments ready"
elif command -v pip3 &>/dev/null; then
  pip3 install --user pre-commit >/dev/null 2>&1 || pip3 install pre-commit >/dev/null 2>&1 || true
  if command -v pre-commit &>/dev/null; then
    pre-commit install-hooks || true
  else
    echo "WARN: install pre-commit (pip install pre-commit) for full validation"
  fi
else
  echo "WARN: pre-commit not found"
fi

install_recommended_skills() {
  bash scripts/install-recommended-skills.sh || echo "WARN: recommended skills install had errors (ok offline)"
}

if [ "$WITH_SKILLS" = true ] || { [ "$CI_MODE" = false ] && [ -t 0 ]; }; then
  if [ "$WITH_SKILLS" = true ]; then
    install_recommended_skills
  elif [ "$CI_MODE" = false ]; then
    read -r -p "Install recommended community skills now? [y/N] " yn
    case "$yn" in
      [Yy]*) install_recommended_skills ;;
    esac
  fi
fi

echo ""
echo "Bootstrap complete."
echo "Next:"
echo "  1. Pick a stack: docs/stacks/INDEX.md"
echo "  2. Add code under services/ apps/ (or src/)"
echo "  3. Work on a feature branch — hooks + CI + release-please are automatic"
