#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

install_template() {
  local source="$1"
  local dest="$2"
  if [[ -e "$dest" ]]; then
    echo "✓ $dest exists; leaving live config untouched"
    return
  fi
  mkdir -p "$(dirname "$dest")"
  cp "$source" "$dest"
  echo "✓ installed template $dest"
}

install_template templates/codex/config.example.toml "$HOME/.codex/config.example.toml"
install_template templates/claude/settings.example.json "$HOME/.claude/settings.example.json"
install_template templates/pi/settings.example.json "$HOME/.pi/agent/settings.example.json"
install_template templates/zshrc.local.example "$HOME/.zshrc.local.example"

cat <<'EOF'

Templates installed as *.example.* only. Do not copy auth files, sqlite DBs,
session logs, paste caches, shell snapshots, run history, or outboxes.
EOF
