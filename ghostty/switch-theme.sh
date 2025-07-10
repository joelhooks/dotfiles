#!/bin/bash

# Ghostty Catppuccin theme switcher
CONFIG_FILE="$HOME/Library/Application Support/com.mitchellh.ghostty/config"

echo "🎨 Catppuccin themes for Ghostty:"
echo ""
echo "1. Latte (Light)"
echo "2. Frappé (Medium Light)"
echo "3. Macchiato (Medium Dark) - Current"
echo "4. Mocha (Dark)"
echo ""

read -p "Select theme (1-4): " choice

case $choice in
    1) 
        theme="catppuccin-latte"
        icon="glass"
        bg_color="#eff1f5"
        ;;
    2) 
        theme="catppuccin-frappe"
        icon="blueprint"
        bg_color="#303446"
        ;;
    3) 
        theme="catppuccin-macchiato"
        icon="official"
        bg_color="#24273a"
        ;;
    4) 
        theme="catppuccin-mocha"
        icon="microchip"
        bg_color="#1e1e2e"
        ;;
    *) 
        echo "❌ Invalid selection"
        exit 1
        ;;
esac

# Update theme
sed -i '' "s/^theme = .*/theme = $theme/" "$CONFIG_FILE"
sed -i '' "s/^macos-icon = .*/macos-icon = $icon/" "$CONFIG_FILE"
sed -i '' "s/^unfocused-split-fill = .*/unfocused-split-fill = $bg_color/" "$CONFIG_FILE"

echo ""
echo "✅ Theme switched to: $theme"
echo "🔄 Reload Ghostty config with Cmd+R or restart Ghostty" 