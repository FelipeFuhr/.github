#!/usr/bin/env bash
set -euo pipefail
bad=
while IFS= read -r -d '' f; do
  grep -qE '^(<{7}|={7}|>{7})' "$f" 2>/dev/null && bad="$bad $f"
done < <(git diff --cached --name-only -z)
[ -n "$bad" ] && { echo "merge markers in:$bad" >&2; exit 1; }
