#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "🔎 dotfiles doctor"

zsh -n .zshrc
echo "✓ .zshrc syntax"

script_files=(install.sh sync-from-system.sh)
while IFS= read -r script; do
  script_files+=("$script")
done < <(find scripts -type f -name '*.sh' | sort)

for script in "${script_files[@]}"; do
  bash -n "$script"
done
echo "✓ shell scripts syntax"

if command -v zellij >/dev/null 2>&1; then
  zellij setup --check >/tmp/dotfiles-zellij-check.log
  echo "✓ zellij config"
else
  echo "⚠ zellij missing, skipped config check"
fi

if command -v python3 >/dev/null 2>&1; then
  python3 - <<'PY'
import json
from pathlib import Path
for path in Path('templates').rglob('*.json'):
    json.loads(path.read_text())
PY
  echo "✓ JSON templates"
fi

if command -v brew >/dev/null 2>&1 && [[ -f Brewfile ]]; then
  brew bundle check --no-upgrade --file Brewfile >/tmp/dotfiles-brew-bundle-check.log 2>&1 \
    && echo "✓ Brewfile satisfied" \
    || echo "⚠ Brewfile has missing deps; run ./scripts/bootstrap-macos.sh when ready"
fi

scan_files=()
while IFS= read -r -d '' file; do
  scan_files+=("$file")
done < <(git ls-files -z -co --exclude-standard)

filtered_scan_files=()
for file in "${scan_files[@]}"; do
  [[ "$file" == "scripts/doctor.sh" ]] && continue
  filtered_scan_files+=("$file")
done
leaks=""
if (( ${#filtered_scan_files[@]} > 0 )); then
  leaks=$(grep -InE '(vck_|xaat-|BEGIN (RSA|OPENSSH|PRIVATE)|github_pat_|ghp_|sk-[A-Za-z0-9]{20,}|AIza|npm_)' -- "${filtered_scan_files[@]}" || true)
fi
if [[ -n "$leaks" ]]; then
  echo "✗ possible secret leak:" >&2
  printf '%s\n' "$leaks" >&2
  exit 1
fi
echo "✓ obvious secret scan"

if git status --short --untracked-files=all | grep -E '^(.. )?\.pi/' >/dev/null; then
  echo "✗ Pi runtime files are visible to git" >&2
  git status --short --untracked-files=all >&2
  exit 1
fi
echo "✓ Pi runtime files ignored"

git status --short --untracked-files=all
