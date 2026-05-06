#!/usr/bin/env bash
set -euo pipefail
subject=$(head -n1 "$1")
pattern='^(feat|fix|docs|chore|refactor|test|ci|perf|style|build|revert)(\([a-z0-9-]+\))?: .{1,100}$'
printf '%s' "$subject" | grep -qE "$pattern" || { printf 'non-conventional commit message: %s\n' "$subject" >&2; exit 1; }
