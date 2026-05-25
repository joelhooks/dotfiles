#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew missing. Install from https://brew.sh first." >&2
  exit 1
fi

for formula in postgresql@17 valkey redis; do
  if brew list "$formula" >/dev/null 2>&1; then
    echo "✓ $formula installed"
  else
    echo "↓ installing $formula"
    brew install "$formula"
  fi
done

cat <<'EOF'

Local service commands:
  brew services start postgresql@17
  brew services stop postgresql@17
  brew services start valkey        # Redis-compatible OSS default
  brew services stop valkey
  brew services start redis         # Only when a project explicitly expects Redis
  brew services stop redis

Project-local containers are still preferred when a repo ships docker-compose.yml.
EOF

psql --version || true
valkey-server --version || true
redis-server --version || true
