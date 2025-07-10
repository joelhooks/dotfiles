#!/bin/bash

# Joel's Dotfiles Installer
# This script sets up all the configurations

set -e  # Exit on error

echo "🚀 Installing Joel's dotfiles..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create necessary directories
echo -e "${BLUE}Creating config directories...${NC}"
mkdir -p ~/.config/zellij/{themes,layouts}
mkdir -p ~/.config/atuin/themes
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"

# Install Zsh config
echo -e "${BLUE}Installing Zsh configuration...${NC}"
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc.backup
    echo "  ✓ Backed up existing .zshrc to .zshrc.backup"
fi
cp .zshrc ~/.zshrc
echo -e "${GREEN}  ✓ Zsh config installed${NC}"

# Install Zellij
echo -e "${BLUE}Installing Zellij configuration...${NC}"
cp zellij/config.kdl ~/.config/zellij/
cp -r zellij/themes/* ~/.config/zellij/themes/
cp -r zellij/layouts/* ~/.config/zellij/layouts/
cp zellij/zellij-sessionizer.sh ~/.config/zellij/
chmod +x ~/.config/zellij/zellij-sessionizer.sh
echo -e "${GREEN}  ✓ Zellij config installed${NC}"

# Install Atuin
echo -e "${BLUE}Installing Atuin configuration...${NC}"
cp atuin/config.toml ~/.config/atuin/
cp -r atuin/themes/* ~/.config/atuin/themes/
echo -e "${GREEN}  ✓ Atuin config installed${NC}"

# Install Ghostty
echo -e "${BLUE}Installing Ghostty configuration...${NC}"
cp ghostty/config "$HOME/Library/Application Support/com.mitchellh.ghostty/"
cp ghostty/switch-theme.sh "$HOME/Library/Application Support/com.mitchellh.ghostty/"
chmod +x "$HOME/Library/Application Support/com.mitchellh.ghostty/switch-theme.sh"
echo -e "${GREEN}  ✓ Ghostty config installed${NC}"

# Install Karabiner
echo -e "${BLUE}Installing Karabiner configuration...${NC}"
if [ -f ~/.config/karabiner.edn ]; then
    cp ~/.config/karabiner.edn ~/.config/karabiner.edn.backup
    echo "  ✓ Backed up existing karabiner.edn to karabiner.edn.backup"
fi
cp karabiner/karabiner.edn ~/.config/
echo -e "${GREEN}  ✓ Karabiner config installed${NC}"

# Copy cheatsheets
echo -e "${BLUE}Installing cheatsheets...${NC}"
cp ghostty/cheatsheet.md "$HOME/Library/Application Support/com.mitchellh.ghostty/"
cp zellij/cheatsheet.md ~/.config/zellij/
cp atuin/cheatsheet.md ~/.config/atuin/
cp karabiner/cheatsheet.md ~/.config/
echo -e "${GREEN}  ✓ Cheatsheets installed${NC}"

echo ""
echo -e "${GREEN}✨ Dotfiles installation complete!${NC}"
echo ""
echo "🎯 Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Start Zellij: zj"
echo "  3. Try Atuin search: Ctrl+R"
echo "  4. Reload Ghostty config: Cmd+R"
echo "  5. If using Goku, run: goku to compile Karabiner config"
echo ""
echo "📚 Cheatsheets available:"
echo "  - Zellij: ~/.config/zellij/cheatsheet.md"
echo "  - Atuin: ~/.config/atuin/cheatsheet.md"
echo "  - Ghostty: ~/Library/Application Support/com.mitchellh.ghostty/cheatsheet.md"
echo "  - Karabiner: ~/.config/karabiner/cheatsheet.md" 