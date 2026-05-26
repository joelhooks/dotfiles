#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

manifest="manifests/agent-skill-install.tsv"
apply=0
replace_links=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply)
      apply=1
      ;;
    --replace-links)
      replace_links=1
      ;;
    --help|-h)
      cat <<'EOF'
Usage: ./scripts/bootstrap-agent-skills.sh [--apply] [--replace-links] [manifest.tsv]

Dry-runs by default. With --apply, symlinks curated skills from the manifest
into safe consumer skill directories.

Safety rules:
  - Source must exist and contain SKILL.md.
  - Consumer root must be a real directory, not a symlink.
  - Existing real files/dirs are never overwritten.
  - Existing links to other sources are skipped unless --replace-links is used.
EOF
      exit 0
      ;;
    *)
      manifest="$1"
      ;;
  esac
  shift
done

expand_path() {
  local raw="$1"
  raw="${raw/#\~/$HOME}"
  raw="${raw//\$HOME/$HOME}"
  printf '%s' "$raw"
}

target_dir() {
  case "$1" in
    agents) printf '%s/.agents/skills' "$HOME" ;;
    pi-agent) printf '%s/.pi/agent/skills' "$HOME" ;;
    pi) printf '%s/.pi/skills' "$HOME" ;;
    claude) printf '%s/.claude/skills' "$HOME" ;;
    codex) printf '%s/.codex/skills' "$HOME" ;;
    opencode) printf '%s/.opencode/skills' "$HOME" ;;
    opencode-config-skill) printf '%s/.config/opencode/skill' "$HOME" ;;
    opencode-config-skills) printf '%s/.config/opencode/skills' "$HOME" ;;
    *) return 1 ;;
  esac
}

install_link() {
  local name="$1"
  local source="$2"
  local target="$3"
  local dest_dir dest

  dest_dir="$(target_dir "$target")" || {
    echo "skip $name -> $target: unknown target"
    return
  }
  dest="$dest_dir/$name"

  if [[ ! -d "$source" || ! -f "$source/SKILL.md" ]]; then
    echo "skip $name -> $target: missing source $source"
    return
  fi

  if [[ -L "$dest_dir" ]]; then
    echo "skip $name -> $target: consumer root is symlink ($dest_dir -> $(readlink "$dest_dir"))"
    return
  fi

  if [[ ! -d "$dest_dir" ]]; then
    if [[ "$apply" -eq 1 ]]; then
      mkdir -p "$dest_dir"
    else
      echo "would mkdir $dest_dir"
    fi
  fi

  if [[ -L "$dest" ]]; then
    local current
    current="$(readlink "$dest")"
    if [[ "$current" == "$source" ]]; then
      echo "ok $name -> $target"
      return
    fi
    if [[ "$replace_links" -ne 1 ]]; then
      echo "skip $name -> $target: existing link points to $current"
      return
    fi
  elif [[ -e "$dest" ]]; then
    echo "skip $name -> $target: existing real path $dest"
    return
  fi

  if [[ "$apply" -eq 1 ]]; then
    ln -sfn "$source" "$dest"
    echo "linked $name -> $dest"
  else
    echo "would link $name -> $dest"
  fi
}

if [[ ! -f "$manifest" ]]; then
  echo "Missing skill install manifest: $manifest" >&2
  exit 1
fi

if [[ "$apply" -eq 0 ]]; then
  echo "Dry run. Re-run with --apply to create links."
fi

while IFS=$'\t' read -r name source_path targets tier policy reason; do
  [[ -z "${name:-}" || "$name" == \#* ]] && continue
  [[ "$policy" == "symlink" ]] || {
    echo "skip $name: unsupported policy $policy"
    continue
  }
  source="$(expand_path "$source_path")"
  IFS=',' read -r -a target_list <<< "$targets"
  for target in "${target_list[@]}"; do
    install_link "$name" "$source" "$target"
  done
done < "$manifest"
