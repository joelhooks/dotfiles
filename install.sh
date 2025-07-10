#!/bin/bash

# Install dotfiles - applies configs FROM repo TO system
# Creates backups of existing configs before overwriting

set -e

echo "🚀 Installing dotfiles..."
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Backup directory
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# Function to create backup
backup_if_exists() {
    local target="$1"
    local backup_name="$2"
    
    if [ -e "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        if [ -d "$target" ]; then
            cp -r "$target" "$BACKUP_DIR/$backup_name"
        else
            cp "$target" "$BACKUP_DIR/$backup_name"
        fi
        echo -e "${YELLOW}  📦 Backed up existing $backup_name${NC}"
        return 0
    fi
    return 1
}

# Function to install a config
install_config() {
    local source="$1"
    local dest="$2"
    local name="$3"
    local backup_name="${4:-$(basename "$dest")}"
    
    if [ ! -e "$source" ]; then
        echo -e "${RED}  ✗ Source not found: $source${NC}"
        return 1
    fi
    
    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"
    
    # Backup existing config
    backup_if_exists "$dest" "$backup_name"
    
    # Install new config
    if [ -d "$source" ]; then
        rsync -av --delete "$source/" "$dest/"
    else
        cp "$source" "$dest"
    fi
    
    echo -e "${GREEN}  ✓ Installed $name${NC}"
}

# Check if running from repo root
if [ ! -f "install.sh" ]; then
    echo -e "${RED}Error: Run this script from the dotfiles repo root!${NC}"
    exit 1
fi

# Zsh
echo -e "${BLUE}Installing Zsh config...${NC}"
install_config .zshrc ~/.zshrc "zshrc"

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${BLUE}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo -e "${GREEN}  ✓ Installed Oh My Zsh${NC}"
fi

# Install Zsh plugins
echo -e "${BLUE}Installing Zsh plugins...${NC}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    echo -e "${GREEN}  ✓ Installed zsh-autosuggestions${NC}"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    echo -e "${GREEN}  ✓ Installed zsh-syntax-highlighting${NC}"
fi

# Pure prompt
if [ ! -d "$ZSH_CUSTOM/plugins/pure" ]; then
    mkdir -p "$ZSH_CUSTOM/plugins/pure"
    git clone https://github.com/sindresorhus/pure.git "$ZSH_CUSTOM/plugins/pure"
    ln -sf "$ZSH_CUSTOM/plugins/pure/pure.zsh" "$HOME/.zsh/pure/prompt_pure_setup"
    ln -sf "$ZSH_CUSTOM/plugins/pure/async.zsh" "$HOME/.zsh/pure/async"
    echo -e "${GREEN}  ✓ Installed pure prompt${NC}"
fi

# Zellij
echo -e "${BLUE}Installing Zellij config...${NC}"
install_config zellij/config.kdl ~/.config/zellij/config.kdl "config"
install_config zellij/themes ~/.config/zellij/themes "themes" "zellij-themes"
install_config zellij/layouts ~/.config/zellij/layouts "layouts" "zellij-layouts"
install_config zellij/zellij-sessionizer.sh ~/.config/zellij/zellij-sessionizer.sh "sessionizer"
chmod +x ~/.config/zellij/zellij-sessionizer.sh
install_config zellij/README.md ~/.config/zellij/README.md "README"

# Atuin
echo -e "${BLUE}Installing Atuin config...${NC}"
install_config atuin/config.toml ~/.config/atuin/config.toml "config"
install_config atuin/themes ~/.config/atuin/themes "themes" "atuin-themes"
install_config atuin/README.md ~/.config/atuin/README.md "README"

# Ghostty
echo -e "${BLUE}Installing Ghostty config...${NC}"
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
install_config ghostty/config "$GHOSTTY_DIR/config" "config"
install_config ghostty/switch-theme.sh "$GHOSTTY_DIR/switch-theme.sh" "theme switcher"
chmod +x "$GHOSTTY_DIR/switch-theme.sh"
install_config ghostty/README.md "$GHOSTTY_DIR/README.md" "README"

# Karabiner
echo -e "${BLUE}Installing Karabiner config...${NC}"
install_config karabiner/karabiner.edn ~/.config/karabiner.edn "config"
install_config karabiner/README.md ~/.config/karabiner/README.md "README"

# Check for required tools
echo ""
echo -e "${BLUE}Checking required tools...${NC}"

check_tool() {
    local tool="$1"
    local install_cmd="$2"
    
    if command -v "$tool" &> /dev/null; then
        echo -e "${GREEN}  ✓ $tool is installed${NC}"
    else
        echo -e "${YELLOW}  ⚠ $tool is not installed${NC}"
        echo -e "    Install with: $install_cmd"
    fi
}

check_tool "zellij" "brew install zellij"
check_tool "atuin" "brew install atuin"
check_tool "ghostty" "Download from https://ghostty.org"
check_tool "goku" "brew install yqrashawn/goku/goku"
check_tool "fd" "brew install fd"
check_tool "fzf" "brew install fzf"
check_tool "tree" "brew install tree"
check_tool "nvim" "brew install neovim"
check_tool "rsync" "brew install rsync"

echo ""
if [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}📦 Backups saved to: $BACKUP_DIR${NC}"
fi
echo -e "${GREEN}✨ Installation complete!${NC}"
echo ""
echo "Restart your terminal or run: source ~/.zshrc"
echo ""
echo "To sync changes back to the repo, run: ./sync-from-system.sh" 