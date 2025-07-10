#!/bin/bash

# Sync configs FROM system TO dotfiles repo
# This pulls any changes you've made locally back into the repo

set -e

echo "📥 Syncing configs from system to dotfiles repo..."
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to sync a file/directory
sync_config() {
    local source="$1"
    local dest="$2"
    local name="$3"
    
    if [ -e "$source" ]; then
        if [ -d "$source" ]; then
            rsync -av --delete "$source/" "$dest/"
        else
            cp "$source" "$dest"
        fi
        echo -e "${GREEN}  ✓ Synced $name${NC}"
    else
        echo -e "${YELLOW}  ⚠ Skipped $name (not found)${NC}"
    fi
}

# Zsh
echo -e "${BLUE}Syncing Zsh...${NC}"
sync_config ~/.zshrc .zshrc "zshrc"

# Zellij
echo -e "${BLUE}Syncing Zellij...${NC}"
sync_config ~/.config/zellij/config.kdl zellij/config.kdl "config"
sync_config ~/.config/zellij/themes zellij/themes "themes"
sync_config ~/.config/zellij/layouts zellij/layouts "layouts"
sync_config ~/.config/zellij/zellij-sessionizer.sh zellij/zellij-sessionizer.sh "sessionizer"
sync_config ~/.config/zellij/README.md zellij/README.md "README"

# Atuin
echo -e "${BLUE}Syncing Atuin...${NC}"
sync_config ~/.config/atuin/config.toml atuin/config.toml "config"
sync_config ~/.config/atuin/themes atuin/themes "themes"
sync_config ~/.config/atuin/README.md atuin/README.md "README"

# Ghostty
echo -e "${BLUE}Syncing Ghostty...${NC}"
sync_config "$HOME/Library/Application Support/com.mitchellh.ghostty/config" ghostty/config "config"
sync_config "$HOME/Library/Application Support/com.mitchellh.ghostty/switch-theme.sh" ghostty/switch-theme.sh "theme switcher"
sync_config "$HOME/Library/Application Support/com.mitchellh.ghostty/README.md" ghostty/README.md "README"

# Karabiner
echo -e "${BLUE}Syncing Karabiner...${NC}"
sync_config ~/.config/karabiner.edn karabiner/karabiner.edn "config"
sync_config ~/.config/karabiner/README.md karabiner/README.md "README" 2>/dev/null || true

echo ""
echo -e "${GREEN}✨ Sync complete!${NC}"
echo ""
echo "Review changes with: git status"
echo "Commit changes with: git add -A && git commit -m 'Update configs from system'" 