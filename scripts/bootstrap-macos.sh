#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew missing. Install from https://brew.sh first." >&2
  exit 1
fi

brew bundle --file Brewfile

# Tasteful macOS defaults. Safe, reversible, and intentionally boring.
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.dock autohide -bool true

killall Finder >/dev/null 2>&1 || true
killall Dock >/dev/null 2>&1 || true

echo "✨ macOS baseline applied"
