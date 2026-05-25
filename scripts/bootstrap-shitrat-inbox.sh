#!/usr/bin/env bash
set -euo pipefail

DARK_WIZARD_DIR="${DARK_WIZARD_DIR:-$HOME/Code/joelhooks/dark-wizard}"
PI_SKILLS_DIR="${PI_SKILLS_DIR:-$HOME/.pi/agent/skills}"
CLAUDE_SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
CODEX_SKILLS_DIR="${CODEX_SKILLS_DIR:-$HOME/.codex/skills}"
SOURCE="$DARK_WIZARD_DIR/skills/joels-inbox/SKILL.md"

if [[ ! -f "$SOURCE" ]]; then
  cat >&2 <<EOF
Missing joels-inbox skill source: $SOURCE
Clone or pull dark-wizard first, or set DARK_WIZARD_DIR.
EOF
  exit 1
fi

for skills_dir in "$PI_SKILLS_DIR" "$CLAUDE_SKILLS_DIR" "$CODEX_SKILLS_DIR"; do
  target_dir="$skills_dir/joels-inbox"
  target="$target_dir/SKILL.md"
  mkdir -p "$target_dir"
  ln -sfn "$SOURCE" "$target"
  printf 'joels-inbox skill linked\nsource: %s\ntarget: %s\n' "$SOURCE" "$target"
done
