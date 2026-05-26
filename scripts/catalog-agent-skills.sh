#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

roots_file="${ROOTS_FILE:-manifests/agent-skill-roots.tsv}"

usage() {
  cat <<'EOF'
Usage: ./scripts/catalog-agent-skills.sh [--summary|--skills|--broken|--markdown|--all]

Audits configured skill roots without mutating them.

Modes:
  --summary   Count SKILL.md files per configured root. Default.
  --skills    List discovered skills with root id, name, relative path, description.
  --broken    List broken first-level symlinks in known consumer dirs.
  --markdown  Print a compact Markdown report.
  --all       Run summary, broken, then skills.
EOF
}

expand_path() {
  local raw="$1"
  raw="${raw/#\~/$HOME}"
  raw="${raw//\$HOME/$HOME}"
  printf '%s' "$raw"
}

count_skills() {
  local root="$1"
  root="$(cd "$root" && pwd -P)"
  find "$root" -name SKILL.md -not -path '*/node_modules/*' 2>/dev/null | wc -l | tr -d ' '
}

count_consumer_skills() {
  local root="$1"
  find -L "$root" -mindepth 2 -maxdepth 2 -name SKILL.md -not -path '*/node_modules/*' 2>/dev/null | wc -l | tr -d ' '
}

skill_name() {
  local file="$1"
  local name
  name="$(awk '
    BEGIN { in_fm=0 }
    NR == 1 && $0 == "---" { in_fm=1; next }
    in_fm && $0 == "---" { exit }
    in_fm && $0 ~ /^name:[[:space:]]*/ {
      sub(/^name:[[:space:]]*/, "", $0)
      gsub(/^["'\'']|["'\'']$/, "", $0)
      print $0
      exit
    }
  ' "$file")"
  if [[ -z "$name" ]]; then
    name="$(basename "$(dirname "$file")")"
  fi
  printf '%s' "$name"
}

skill_description() {
  local file="$1"
  awk '
    BEGIN { in_fm=0 }
    NR == 1 && $0 == "---" { in_fm=1; next }
    in_fm && $0 == "---" { exit }
    in_fm && $0 ~ /^description:[[:space:]]*/ {
      sub(/^description:[[:space:]]*/, "", $0)
      gsub(/^["'\'']|["'\'']$/, "", $0)
      print $0
      exit
    }
  ' "$file" | tr '\t' ' '
}

summary() {
  printf 'count\tid\tscope\tstatus\trole\tpath\n'
  while IFS=$'\t' read -r id scope status path role notes; do
    [[ -z "${id:-}" || "$id" == \#* ]] && continue
    local expanded count
    expanded="$(expand_path "$path")"
    if [[ -d "$expanded" && "$scope" == "consumer" && "$id" != "codex-plugin-cache" ]]; then
      count="$(count_consumer_skills "$expanded")"
    elif [[ -d "$expanded" ]]; then
      count="$(count_skills "$expanded")"
    elif [[ -f "$expanded" ]]; then
      count="file"
    else
      count="missing"
    fi
    printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$count" "$id" "$scope" "$status" "$role" "$expanded"
  done < "$roots_file"
}

skills() {
  printf 'root\tname\trelpath\tdescription\n'
  while IFS=$'\t' read -r id scope status path role notes; do
    [[ -z "${id:-}" || "$id" == \#* ]] && continue
    [[ "$role" == "lock" ]] && continue
    local expanded
    expanded="$(expand_path "$path")"
    [[ -d "$expanded" ]] || continue
    expanded="$(cd "$expanded" && pwd -P)"
    local find_args=("$expanded" -name SKILL.md -not -path '*/node_modules/*')
    local find_cmd=(find "$expanded")
    if [[ "$scope" == "consumer" && "$id" != "codex-plugin-cache" ]]; then
      find_cmd=(find -L "$expanded" -mindepth 2 -maxdepth 2)
    fi

    while IFS= read -r file; do
      local name desc rel
      name="$(skill_name "$file")"
      desc="$(skill_description "$file")"
      rel="${file#"$expanded"/}"
      printf '%s\t%s\t%s\t%s\n' "$id" "$name" "$rel" "$desc"
    done < <("${find_cmd[@]}" "${find_args[@]:1}" 2>/dev/null | sort)
  done < "$roots_file"
}

broken() {
  local dirs=(
    "$HOME/.agents/skills"
    "$HOME/.pi/agent/skills"
    "$HOME/.pi/skills"
    "$HOME/.claude/skills"
    "$HOME/.codex/skills"
    "$HOME/.opencode/skills"
    "$HOME/.config/opencode/skill"
    "$HOME/.config/opencode/skills"
  )
  printf 'consumer\tbroken_link\n'
  local dir
  for dir in "${dirs[@]}"; do
    [[ -e "$dir" || -L "$dir" ]] || continue
    while IFS= read -r link; do
      printf '%s\t%s\n' "$dir" "$link"
    done < <(find "$dir" -maxdepth 1 -type l ! -exec test -e {} \; -print 2>/dev/null | sort)
  done
}

markdown() {
  printf '# Agent Skill Catalog\n\n'
  printf 'Generated from `%s` on `%s`.\n\n' "$roots_file" "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf '## Roots\n\n'
  printf '| Count | Root | Scope | Role | Path |\n'
  printf '| ---: | --- | --- | --- | --- |\n'
  summary | tail -n +2 | while IFS=$'\t' read -r count id scope status role path; do
    printf '| %s | `%s` | %s | %s | `%s` |\n' "$count" "$id" "$scope" "$role" "$path"
  done
  printf '\n## Broken Consumer Symlinks\n\n'
  local had=0
  while IFS=$'\t' read -r consumer link; do
    if [[ "$consumer" == "consumer" ]]; then
      continue
    fi
    if [[ "$had" -eq 0 ]]; then
      printf '| Consumer | Broken Link |\n| --- | --- |\n'
      had=1
    fi
    printf '| `%s` | `%s` |\n' "$consumer" "$link"
  done < <(broken)
  if [[ "$had" -eq 0 ]]; then
    printf 'No broken first-level symlinks found.\n'
  fi
}

mode="${1:---summary}"
case "$mode" in
  --summary) summary ;;
  --skills) skills ;;
  --broken) broken ;;
  --markdown) markdown ;;
  --all)
    summary
    printf '\n'
    broken
    printf '\n'
    skills
    ;;
  -h|--help) usage ;;
  *) usage >&2; exit 2 ;;
esac
