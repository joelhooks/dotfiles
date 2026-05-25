#!/usr/bin/env bash
set -euo pipefail

require_tool() {
  local tool="$1"
  local install="$2"
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "Missing $tool. Install with: $install" >&2
    return 1
  fi
}

require_tool fnm "brew install fnm"
require_tool bun "brew install bun"
require_tool pnpm "brew install pnpm"
require_tool uv "brew install uv"

# Node: fnm owns versions; default to current LTS.
fnm install --lts --corepack-enabled
fnm default lts/latest
fnm use lts/latest

if command -v corepack >/dev/null 2>&1; then
  corepack enable
fi

# Python: uv owns project/env workflows. Keep a modern Python available.
uv python install 3.12

node --version
pnpm --version
bun --version
uv --version
python3 --version

echo "✨ runtimes ready: fnm LTS Node, pnpm, Bun, uv/Python"
