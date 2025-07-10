#!/bin/bash

echo "🚀 Installing zsh tools and plugins..."

# Install Homebrew packages
echo "📦 Installing Homebrew packages..."
brew install fd fzf tree neovim

# Install Oh My Zsh custom plugins
echo "🔌 Installing Oh My Zsh plugins..."
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
else
  echo "✓ zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
else
  echo "✓ zsh-syntax-highlighting already installed"
fi

# Create cache directory for completions
mkdir -p ~/.zsh/cache

# Install fzf key bindings
echo "⌨️  Setting up fzf key bindings..."
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

echo "✅ Installation complete!"
echo ""
echo "🎉 Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Try these commands:"
echo "   - Press Ctrl+R for better history search (via fzf)"
echo "   - Type 'cd' and press Tab to see directory suggestions"
echo "   - Use 'z' to jump to frecent directories"
echo "   - Type commands to see syntax highlighting"
echo ""
echo "💡 Pro tips:"
echo "   - Create ~/.zshrc.local for machine-specific configs"
echo "   - Use 'mkd dirname' to create and enter directories"
echo "   - Use 'extract archive.zip' to extract any archive format"
