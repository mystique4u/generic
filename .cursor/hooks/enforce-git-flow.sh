#!/usr/bin/env bash
# Deterministic git-flow enforcement for agents (Cursor beforeShellExecution).
# failClosed in hooks.json — invalid JSON / crash blocks the command.
set -euo pipefail

input=$(cat)
command=$(printf '%s' "$input" | python3 -c 'import sys,json
try:
    print(json.load(sys.stdin).get("command",""))
except Exception:
    print("")')

deny() {
  local msg="$1"
  python3 -c 'import json,sys; print(json.dumps({"permission":"deny","user_message":sys.argv[1],"agent_message":sys.argv[1]}))' "$msg"
  exit 0
}

ask() {
  local msg="$1"
  python3 -c 'import json,sys; print(json.dumps({"permission":"ask","user_message":sys.argv[1],"agent_message":sys.argv[1]}))' "$msg"
  exit 0
}

if [ -z "$command" ]; then
  echo '{ "permission": "allow" }'
  exit 0
fi

# Evaluate policy in Python for precise tokenization (avoid false positives in docs text).
python3 - "$command" <<'PY'
import json, re, subprocess, sys

command = sys.argv[1]

def out(obj):
    print(json.dumps(obj))
    raise SystemExit(0)

def deny(msg):
    out({"permission": "deny", "user_message": msg, "agent_message": msg})

def ask(msg):
    out({"permission": "ask", "user_message": msg, "agent_message": msg})

# Split on shell operators; inspect each segment that invokes git
segments = re.split(r"(?:&&|\|\||;|\n)", command)
git_segments = []
for seg in segments:
    s = seg.strip()
    if re.search(r"(^|[|&;]\s*)git\s+", s) or s.startswith("git "):
        git_segments.append(s)

if not git_segments:
    out({"permission": "allow"})

def tokens(seg: str) -> list[str]:
    # rough argv split; good enough for flag detection
    return re.findall(r"""(?:[^\s"'`]+|"[^"]*"|'[^']*')""", seg)

branch = ""
try:
    branch = subprocess.check_output(
        ["git", "branch", "--show-current"],
        stderr=subprocess.DEVNULL,
        text=True,
    ).strip()
except Exception:
    branch = ""

for seg in git_segments:
    toks = tokens(seg)
    # normalize: find 'git' then subcommand
    try:
        gi = next(i for i, t in enumerate(toks) if t == "git" or t.endswith("/git"))
    except StopIteration:
        continue
    args = [t.strip("'\"") for t in toks[gi + 1 :]]
    if not args:
        continue
    sub = args[0]
    flags = set(args[1:])

    if "--no-verify" in flags or "--no-gpg-sign" in flags:
        deny(
            "Blocked: skipping git hooks (--no-verify / --no-gpg-sign) is forbidden. "
            "Fix validate.sh failures instead."
        )

    if sub == "push" and (flags & {"--force", "--force-with-lease", "-f"}):
        joined = " ".join(args)
        if re.search(r"(^|\s)main(\s|$)", joined) or branch in ("main", "master"):
            deny("Blocked: force-push to main is forbidden.")
        ask("Force-push requested. Confirm only if you intentionally rewrote history on a feature branch.")

    if sub == "commit" and branch in ("main", "master"):
        deny(
            f"Blocked: do not commit on {branch}. "
            "Create feature/... or fix/... first (see AGENTS.md binding flow)."
        )

    if sub == "push":
        joined = " ".join(args)
        if re.search(r"(^|\s|:)main(\s|$)", joined):
            ask(
                "Push involves main. Prefer a feature-branch PR. "
                "Approve only if this push is intentional."
            )
        if branch in ("main", "master") and not re.search(r"\S+:\S+", joined):
            ask(
                f"You are on {branch}. Pushing from main requires explicit approval. "
                "Prefer feature branches."
            )

out({"permission": "allow"})
PY
