#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "🔎 dotfiles doctor"

zsh -n .zshrc
echo "✓ .zshrc syntax"

for script in install.sh sync-from-system.sh scripts/doctor.sh scripts/bootstrap-agent-tools.sh; do
  bash -n "$script"
done
echo "✓ shell scripts syntax"

if command -v zellij >/dev/null 2>&1; then
  zellij setup --check >/tmp/dotfiles-zellij-check.log
  echo "✓ zellij config"
else
  echo "⚠ zellij missing, skipped config check"
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

if git status --short --untracked-files=all | grep -E '^(.. )?(\.pi/|\.brain/|BRAIN\.md)' >/dev/null; then
  echo "✗ local Brain/Pi runtime files are visible to git" >&2
  git status --short --untracked-files=all >&2
  exit 1
fi
echo "✓ local runtime files ignored"

git status --short --untracked-files=all
