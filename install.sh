#!/usr/bin/env bash

# Install dotfiles - applies configs FROM repo TO system
# Idempotent/resumable: skips current targets and backs up only before replacing
# changed managed paths.

set -euo pipefail

echo "🚀 Installing dotfiles..."
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

BACKUP_DIR=""

target_exists() {
    [ -e "$1" ] || [ -L "$1" ]
}

backup_label() {
    local target="$1"
    target="${target/#$HOME/~}"
    target="${target// /_}"
    target="${target//\//_}"
    target="${target/#~/_home}"
    target="${target##_}"
    printf '%s' "$target"
}

ensure_backup_dir() {
    if [ -z "$BACKUP_DIR" ]; then
        BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
        mkdir -p "$BACKUP_DIR"
    fi
}

# Function to create backup
backup_if_exists() {
    local target="$1"
    local backup_name="$2"

    if target_exists "$target"; then
        ensure_backup_dir
        local backup_path="$BACKUP_DIR/$backup_name"
        local suffix=1
        while target_exists "$backup_path"; do
            backup_path="$BACKUP_DIR/$backup_name.$suffix"
            suffix=$((suffix + 1))
        done
        cp -R -p -P "$target" "$backup_path"
        echo -e "${YELLOW}  📦 Backed up existing $backup_name${NC}"
        return 0
    fi
    return 1
}

file_is_current() {
    local source="$1"
    local dest="$2"

    { [ -f "$dest" ] || [ -L "$dest" ]; } && cmp -s "$source" "$dest"
}

dir_is_current() {
    local source="$1"
    local dest="$2"

    [ -d "$dest" ] || return 1
    [ -z "$(rsync -a --checksum --delete --dry-run --itemize-changes "$source/" "$dest/")" ]
}

install_file() {
    local source="$1"
    local dest="$2"
    local name="$3"
    local backup_name="$4"

    if [ ! -e "$source" ]; then
        echo -e "${RED}  ✗ Source not found: $source${NC}"
        return 1
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"

    if file_is_current "$source" "$dest"; then
        echo -e "${GREEN}  ✓ $name already current${NC}"
        return 0
    fi

    if target_exists "$dest"; then
        backup_if_exists "$dest" "$backup_name"
        rm -rf "$dest"
    fi

    cp -p "$source" "$dest"
    echo -e "${GREEN}  ✓ Installed $name${NC}"
}

install_dir() {
    local source="$1"
    local dest="$2"
    local name="$3"
    local backup_name="$4"

    if [ ! -d "$source" ]; then
        echo -e "${RED}  ✗ Source directory not found: $source${NC}"
        return 1
    fi

    mkdir -p "$(dirname "$dest")"

    if dir_is_current "$source" "$dest"; then
        echo -e "${GREEN}  ✓ $name already current${NC}"
        return 0
    fi

    if target_exists "$dest"; then
        backup_if_exists "$dest" "$backup_name"
        if [ -L "$dest" ] || [ ! -d "$dest" ]; then
            rm -rf "$dest"
        fi
    fi

    mkdir -p "$dest"
    rsync -a --delete "$source/" "$dest/"
    echo -e "${GREEN}  ✓ Installed $name${NC}"
}

install_config() {
    local source="$1"
    local dest="$2"
    local name="$3"
    local backup_name="${4:-$(backup_label "$dest")}"
    
    if [ -d "$source" ]; then
        install_dir "$source" "$dest" "$name" "$backup_name"
    else
        install_file "$source" "$dest" "$name" "$backup_name"
    fi
}

install_symlink() {
    local source="$1"
    local dest="$2"
    local name="$3"
    local backup_name="${4:-$(backup_label "$dest")}"
    local source_abs
    source_abs="$(cd "$(dirname "$source")" && pwd)/$(basename "$source")"

    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$source_abs" ]; then
        echo -e "${GREEN}  ✓ $name already linked${NC}"
        return 0
    fi

    if target_exists "$dest"; then
        backup_if_exists "$dest" "$backup_name"
        rm -rf "$dest"
    fi

    ln -s "$source_abs" "$dest"
    echo -e "${GREEN}  ✓ Linked $name${NC}"
}

ensure_executable() {
    local path="$1"
    local name="$2"

    if [ -x "$path" ]; then
        echo -e "${GREEN}  ✓ $name executable${NC}"
        return 0
    fi

    chmod +x "$path"
    echo -e "${GREEN}  ✓ Made $name executable${NC}"
}

ensure_git_repo() {
    local repo="$1"
    local dest="$2"
    local name="$3"
    shift 3
    local backup_name
    backup_name="$(backup_label "$dest")"

    mkdir -p "$(dirname "$dest")"

    if [ -d "$dest" ] && git -C "$dest" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local missing_required=0
        local required_file
        for required_file in "$@"; do
            if [ ! -e "$dest/$required_file" ]; then
                missing_required=1
                break
            fi
        done

        if [ "$missing_required" -eq 0 ]; then
            echo -e "${GREEN}  ✓ $name already present${NC}"
            return 0
        fi

        echo -e "${YELLOW}  ⚠ $name checkout is incomplete; reinstalling${NC}"
        backup_if_exists "$dest" "$backup_name"
        rm -rf "$dest"
    fi

    if target_exists "$dest"; then
        if [ -d "$dest" ] && [ -z "$(find "$dest" -mindepth 1 -maxdepth 1 -print -quit)" ]; then
            git clone "$repo" "$dest"
            echo -e "${GREEN}  ✓ Installed $name${NC}"
            return 0
        fi

        backup_if_exists "$dest" "$backup_name"
        rm -rf "$dest"
    fi

    git clone "$repo" "$dest"
    local required_file
    for required_file in "$@"; do
        if [ ! -e "$dest/$required_file" ]; then
            echo -e "${RED}  ✗ $name missing expected file after clone: $required_file${NC}"
            return 1
        fi
    done
    echo -e "${GREEN}  ✓ Installed $name${NC}"
}

ensure_link() {
    local source="$1"
    local dest="$2"
    local name="$3"
    local backup_name="${4:-$(backup_label "$dest")}"

    if [ ! -e "$source" ]; then
        echo -e "${RED}  ✗ Link source not found for $name: $source${NC}"
        return 1
    fi

    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$source" ]; then
        echo -e "${GREEN}  ✓ $name already linked${NC}"
        return 0
    fi

    if target_exists "$dest"; then
        backup_if_exists "$dest" "$backup_name"
        rm -rf "$dest"
    fi

    ln -s "$source" "$dest"
    echo -e "${GREEN}  ✓ Linked $name${NC}"
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
    if target_exists "$HOME/.oh-my-zsh"; then
        backup_if_exists "$HOME/.oh-my-zsh" ".oh-my-zsh"
        rm -rf "$HOME/.oh-my-zsh"
    fi
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo -e "${GREEN}  ✓ Installed Oh My Zsh${NC}"
else
    echo -e "${GREEN}  ✓ Oh My Zsh already present${NC}"
fi

# Install Zsh plugins
echo -e "${BLUE}Installing Zsh plugins...${NC}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

ensure_git_repo https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" "zsh-autosuggestions" "zsh-autosuggestions.zsh"
ensure_git_repo https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" "zsh-syntax-highlighting" "zsh-syntax-highlighting.zsh"

# Pure prompt
ensure_git_repo https://github.com/sindresorhus/pure.git "$ZSH_CUSTOM/plugins/pure" "pure prompt" "pure.zsh" "async.zsh"
ensure_link "$ZSH_CUSTOM/plugins/pure/pure.zsh" "$HOME/.zsh/pure/prompt_pure_setup" "pure prompt setup"
ensure_link "$ZSH_CUSTOM/plugins/pure/async.zsh" "$HOME/.zsh/pure/async" "pure async"

# Zellij
echo -e "${BLUE}Installing Zellij config...${NC}"
install_config zellij/config.kdl ~/.config/zellij/config.kdl "config"
install_config zellij/themes ~/.config/zellij/themes "themes" "zellij-themes"
install_config zellij/layouts ~/.config/zellij/layouts "layouts" "zellij-layouts"
install_config zellij/cheats ~/.config/zellij/cheats "cheats" "zellij-cheats"
install_config zellij/zellij-sessionizer.sh ~/.config/zellij/zellij-sessionizer.sh "sessionizer"
ensure_executable ~/.config/zellij/zellij-sessionizer.sh "sessionizer"
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
ensure_executable "$GHOSTTY_DIR/switch-theme.sh" "theme switcher"
install_config ghostty/README.md "$GHOSTTY_DIR/README.md" "README"

# Karabiner
echo -e "${BLUE}Installing Karabiner config...${NC}"
install_config karabiner/karabiner.edn ~/.config/karabiner.edn "config"
install_config karabiner/README.md ~/.config/karabiner/README.md "README"

# Neovim (symlink entire directory)
echo -e "${BLUE}Installing Neovim config...${NC}"
install_symlink nvim ~/.config/nvim "nvim config" "nvim"

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
check_tool "zoxide" "brew install zoxide"
check_tool "eza" "brew install eza"
check_tool "bat" "brew install bat"
check_tool "tree" "brew install tree"
check_tool "nvim" "brew install neovim"
check_tool "rsync" "brew install rsync"
check_tool "gh" "brew install gh"
check_tool "fnm" "brew install fnm"
check_tool "uv" "brew install uv"
check_tool "bun" "brew install bun"
check_tool "pnpm" "brew install pnpm"
check_tool "aws" "brew install awscli"
check_tool "psql" "brew install postgresql@17"
check_tool "valkey-server" "brew install valkey"
check_tool "redis-server" "brew install redis"

echo ""
if [ -n "$BACKUP_DIR" ] && [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}📦 Backups saved to: $BACKUP_DIR${NC}"
fi
echo -e "${GREEN}✨ Installation complete!${NC}"
echo ""
echo "Restart your terminal or run: source ~/.zshrc"
echo ""
echo "To sync changes back to the repo, run: ./sync-from-system.sh"
