#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# Public-safe global Git/GitHub preferences. No tokens, no auth files.
git config --global user.name "Joel Hooks"
git config --global user.email "joelhooks@gmail.com"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global push.default current
git config --global push.autoSetupRemote true
git config --global fetch.prune true
git config --global rerere.enabled true
git config --global branch.sort -committerdate
git config --global tag.sort version:refname
git config --global diff.algorithm histogram
git config --global diff.colorMoved plain
git config --global merge.conflictstyle zdiff3
git config --global commit.verbose true
git config --global core.editor nvim

if command -v gh >/dev/null 2>&1; then
  gh config set git_protocol ssh --host github.com >/dev/null
  if gh auth status -h github.com >/dev/null 2>&1; then
    echo "✓ gh authenticated for github.com"
  else
    echo "⚠ gh is installed but not authenticated. Run: gh auth login -h github.com -p ssh"
  fi
else
  echo "⚠ gh missing. Install with: brew install gh"
fi

echo "✓ Git defaults applied: main branch, SSH GitHub protocol, Joel identity"
