#!/usr/bin/env bash

# Zellij sessionizer - quickly switch between projects
# Inspired by ThePrimeagen's tmux-sessionizer

if [[ $# -eq 1 ]]; then
    selected=$1
else
    # Find directories in common project locations
    selected=$(find ~/Code ~/Desktop -mindepth 1 -maxdepth 2 -type d 2>/dev/null | \
        grep -v node_modules | \
        grep -v .git | \
        fzf --preview 'ls -la {}' --preview-window=right:50%:wrap)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
zellij_running=$(pgrep -x zellij)

if [[ -z $ZELLIJ ]]; then
    # Not in Zellij
    cd "$selected" && zellij attach "$selected_name" || zellij --session "$selected_name" --layout default
else
    # Inside Zellij
    if ! zellij list-sessions | grep -q "^$selected_name"; then
        cd "$selected" && zellij --session "$selected_name" --layout default
    else
        echo "Session $selected_name already exists"
    fi
fi 