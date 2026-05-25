#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
manifest="${1:-manifests/repos.tsv}"

if [[ ! -f "$manifest" ]]; then
  echo "Missing repo manifest: $manifest" >&2
  exit 1
fi

while IFS=$'\t' read -r repo target visibility purpose; do
  [[ -z "${repo:-}" || "$repo" == \#* ]] && continue
  target="${target/#\~/$HOME}"
  if [[ -d "$target/.git" ]]; then
    echo "↻ $repo -> $target"
    git -C "$target" fetch --prune origin || echo "  ⚠ fetch failed for $repo"
    continue
  fi

  echo "↓ $repo -> $target ($visibility)"
  mkdir -p "$(dirname "$target")"
  if command -v gh >/dev/null 2>&1; then
    gh repo clone "$repo" "$target" -- --origin origin || echo "  ⚠ clone failed for $repo"
  else
    git clone "git@github.com:$repo.git" "$target" || echo "  ⚠ clone failed for $repo"
  fi
done < "$manifest"
