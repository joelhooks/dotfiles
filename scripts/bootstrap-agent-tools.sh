#!/usr/bin/env bash
set -euo pipefail

# Non-destructive agent-tool bootstrap/doctor for Joel-flavored machines.
# Installs are intentionally not automatic yet; auth and private overlays need human review.

required=(pi codex claude opencode shitrat secrets joelclaw)
missing=()

for tool in "${required[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '✓ %s -> %s\n' "$tool" "$(command -v "$tool")"
  else
    printf '✗ %s missing\n' "$tool"
    missing+=("$tool")
  fi
done

if command -v secrets >/dev/null 2>&1; then
  secrets status --no-update-check >/dev/null && echo '✓ secrets daemon reachable'
fi

if command -v shitrat >/dev/null 2>&1; then
  shitrat status joelhooks/dotfiles >/dev/null && echo '✓ ShitRat can access joelhooks/dotfiles'
fi

if command -v joelclaw >/dev/null 2>&1; then
  joelclaw status >/dev/null && echo '✓ joelclaw status responds'
fi

if (( ${#missing[@]} > 0 )); then
  echo
  echo 'Missing agent tools:' "${missing[*]}"
  echo 'Install/restore these with the project-specific installer or private machine bootstrap notes.'
  echo 'Do not copy auth files from another machine; use official login flows and secrets leases.'
  exit 1
fi

echo '✨ agent toolchain looks present'
