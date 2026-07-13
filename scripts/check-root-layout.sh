#!/usr/bin/env bash
# Fail if unexpected top-level entries appear (cleanliness).
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ALLOWLIST="$REPO_ROOT/scripts/root-allowlist.txt"

mapfile -t allowed < <(grep -vE '^\s*(#|$)' "$ALLOWLIST")
declare -A ok=()
for name in "${allowed[@]}"; do
  ok["$name"]=1
done

failed=0
while IFS= read -r -d '' entry; do
  base="$(basename "$entry")"
  if [[ -z "${ok[$base]+x}" ]]; then
    echo "Unexpected top-level entry: $base" >&2
    failed=1
  fi
done < <(find "$REPO_ROOT" -mindepth 1 -maxdepth 1 -print0)

if [[ "$failed" -ne 0 ]]; then
  echo "Update scripts/root-allowlist.txt if this path is intentional." >&2
  exit 1
fi
echo "Root layout allowlist OK"
