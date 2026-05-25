#!/usr/bin/env bash
set -euo pipefail

mode="${1:-}"
LOCAL_PATH="${SHITRAT_CACHE_LOCAL_PATH:-$HOME/.shitrat}"
REMOTE="${SHITRAT_CACHE_REMOTE:-${BLAINE_THUNDERBOLT_HOST:-}}"
REMOTE_PATH="${SHITRAT_CACHE_REMOTE_PATH:-~/.shitrat}"

usage() {
  cat <<'EOF'
Usage: sync-shitrat-cache.sh push|pull

Required env:
  SHITRAT_CACHE_REMOTE       SSH remote, e.g. joel@peer-host.local or joel@[fe80::...%en12]

Optional env:
  SHITRAT_CACHE_REMOTE_PATH  Remote cache path. Default: ~/.shitrat
  SHITRAT_CACHE_LOCAL_PATH   Local cache path. Default: ~/.shitrat
  BLAINE_THUNDERBOLT_HOST    Back-compat alias for SHITRAT_CACHE_REMOTE

This syncs ShitRat runtime cache only. Do not commit the cache.
EOF
}

if [[ "$mode" != "push" && "$mode" != "pull" ]]; then
  usage >&2
  exit 2
fi

if [[ -z "$REMOTE" ]]; then
  echo "Missing SHITRAT_CACHE_REMOTE" >&2
  usage >&2
  exit 2
fi

mkdir -p "$LOCAL_PATH"

case "$mode" in
  push)
    rsync -az --delete "$LOCAL_PATH/" "$REMOTE:$REMOTE_PATH/"
    ;;
  pull)
    rsync -az --delete "$REMOTE:$REMOTE_PATH/" "$LOCAL_PATH/"
    ;;
esac

printf 'shitrat cache sync complete\nmode: %s\nlocal: %s\nremote: %s:%s\n' "$mode" "$LOCAL_PATH" "$REMOTE" "$REMOTE_PATH"
