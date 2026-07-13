#!/usr/bin/env bash
# Soft reminder on git push (real validation is the git pre-push hook).
set -euo pipefail
input=$(cat)
command=$(printf '%s' "$input" | python3 -c 'import sys,json
try:
    print(json.load(sys.stdin).get("command",""))
except Exception:
    print("")')

if [[ "$command" =~ git[[:space:]]+push ]] && [[ "$command" =~ main ]]; then
  cat <<'EOF'
{
  "permission": "allow",
  "agent_message": "Push involving main: git pre-push runs validate.sh automatically. Prefer feature branches; release-please handles SemVer on merge to main."
}
EOF
  exit 0
fi

echo '{ "permission": "allow" }'
exit 0
