#!/usr/bin/env bash
set -euo pipefail

DARK_WIZARD_DIR="${DARK_WIZARD_DIR:-$HOME/Code/joelhooks/dark-wizard}"
PI_SKILLS_DIR="${PI_SKILLS_DIR:-$HOME/.pi/agent/skills}"
SOURCE="$DARK_WIZARD_DIR/skills/joels-inbox/SKILL.md"
TARGET_DIR="$PI_SKILLS_DIR/joels-inbox"
TARGET="$TARGET_DIR/SKILL.md"

if [[ ! -f "$SOURCE" ]]; then
  cat >&2 <<EOF
Missing joels-inbox skill source: $SOURCE
Clone or pull dark-wizard first, or set DARK_WIZARD_DIR.
EOF
  exit 1
fi

mkdir -p "$TARGET_DIR"
ln -sfn "$SOURCE" "$TARGET"

printf 'joels-inbox skill linked\nsource: %s\ntarget: %s\n' "$SOURCE" "$TARGET"
