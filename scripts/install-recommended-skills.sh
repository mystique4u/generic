#!/usr/bin/env bash
# Install recommended community skills (best-effort; requires network + npx).
# Sources documented in docs/agent-os.md
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if ! command -v npx &>/dev/null; then
  echo "npx not found — install Node.js to use the skills CLI" >&2
  exit 1
fi

echo "Installing recommended skills via skills CLI..."

install_one() {
  local source="$1"
  local skill="$2"
  echo "→ $source ($skill)"
  npx --yes skills add "$source" --skill "$skill" -y
}

install_one addyosmani/agent-skills test-driven-development
install_one addyosmani/agent-skills security-and-hardening
install_one addyosmani/agent-skills planning-and-task-breakdown
install_one anthropics/skills skill-creator
install_one spencerpauly/awesome-cursor-skills suggesting-cursor-hooks

echo "Done. Check skills-lock.json / .agents/skills for installed skills."
echo "Code review: use .cursor/agents/code-reviewer.md + caveman-review."
echo "Registries: https://skills.sh https://claude-plugins.dev https://cursor.directory"
