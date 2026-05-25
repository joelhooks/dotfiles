#!/usr/bin/env bash
set -euo pipefail

missing=()
for tool in tailscale mkcert portless; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '✓ %s -> %s\n' "$tool" "$(command -v "$tool")"
  else
    printf '⚠ %s missing\n' "$tool"
    missing+=("$tool")
  fi
done

if command -v mkcert >/dev/null 2>&1; then
  mkcert -install
  echo "✓ mkcert local CA installed"
fi

if command -v portless >/dev/null 2>&1; then
  portless trust || true
  echo "✓ portless trust attempted"
fi

if command -v tailscale >/dev/null 2>&1; then
  tailscale status >/dev/null 2>&1 && echo "✓ tailscale logged in" || echo "⚠ tailscale installed but not logged in"
fi

if (( ${#missing[@]} > 0 )); then
  echo "Missing tools: ${missing[*]}"
  echo "Install via Brewfile or project-specific installer."
fi
