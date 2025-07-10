# Joel's Dotfiles 🚀

> A highly optimized macOS development environment featuring Zsh, Zellij, Ghostty, Atuin, and Karabiner configurations.

![Catppuccin Macchiato](https://img.shields.io/badge/theme-catppuccin%20macchiato-purple?style=for-the-badge)
![Zsh](https://img.shields.io/badge/shell-zsh-green?style=for-the-badge)
![macOS](https://img.shields.io/badge/os-macOS-blue?style=for-the-badge)

## 🎨 Preview

This setup features:
- **Catppuccin Macchiato** theme across all tools
- **1 million line** scrollback in terminals
- **GPU-accelerated** terminal rendering
- **Fuzzy history search** with context awareness
- **Advanced keyboard customization** with Karabiner
- **Session persistence** with Zellij

## 📦 What's Included

### [Zsh](.zshrc) - Shell Configuration
- Oh My Zsh with performance optimizations
- Smart aliases and functions
- FZF integration
- Homebrew & pnpm paths
- Pure prompt

### [Zellij](zellij/) - Terminal Multiplexer
- Session management with persistence
- Custom layouts for development
- Project sessionizer script
- Catppuccin themes
- 1M line scrollback

### [Ghostty](ghostty/) - GPU Terminal Emulator
- Native macOS integration
- GPU-accelerated rendering
- 1M line scrollback
- Catppuccin theme switcher
- Optimized keybindings

### [Atuin](atuin/) - Shell History
- Fuzzy search with 25-line preview
- Context-aware filtering (directory/workspace)
- Privacy-focused configuration
- Catppuccin themes (4 accent colors)
- Smart command filtering

### [Karabiner](karabiner/) - Keyboard Customization
- Caps Lock → Escape/Control
- Home row modifiers
- Vim-style navigation
- App-specific shortcuts
- Emoji layer

## 🛠 Installation

### Quick Install

```bash
git clone https://github.com/joelhooks/dotfiles.git ~/Code/joelhooks/dotfiles
cd ~/Code/joelhooks/dotfiles
./install.sh
```

### Manual Installation

Each tool can be installed individually by copying its config files to the appropriate location. See the [install script](install.sh) for details.

## 📚 Documentation

Each tool includes comprehensive documentation:

- [Zsh Configuration](.zshrc) - Aliases and functions
- [Zellij Documentation](zellij/) - Keybindings and layouts
- [Ghostty Documentation](ghostty/) - Terminal shortcuts
- [Atuin Documentation](atuin/) - Search operators
- [Karabiner Documentation](karabiner/) - Keyboard layers

## ⚡ Key Features

### Productivity Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+f` | Zellij project sessionizer |
| `Ctrl+r` | Atuin fuzzy history search |
| `Alt+1-9` | Quick tab switching |
| `Caps Lock` | Escape (tap) / Control (hold) |

### Quick Commands

| Command | Description |
|---------|-------------|
| `zj` | Start Zellij |
| `zs` | Project sessionizer |
| `h` | Atuin search |
| `hs` | History stats |
| `ht` | Switch Atuin theme |
| `gt` | Switch Ghostty theme |
| `v` | Neovim |
| `c` | Cursor editor |

### Development Aliases

| Alias | Command |
|-------|---------|
| `p` | pnpm |
| `px` | pnpm dlx |
| `gst` | git status (short) |
| `glog` | git log (graph) |
| `dev` | cd ~/Code |
| `mkd` | Create & enter directory |

## 🎨 Theme Consistency

All tools are configured with **Catppuccin Macchiato** for a consistent look:

- Terminal colors
- UI elements
- Syntax highlighting
- Status bars

Theme switchers are included for easy customization:
- `ht` - Switch Atuin theme
- `gt` - Switch Ghostty theme

## 🔧 Requirements

### Required Tools
- [Homebrew](https://brew.sh)
- [Oh My Zsh](https://ohmyz.sh)
- [Zellij](https://zellij.dev)
- [Ghostty](https://ghostty.org)
- [Atuin](https://atuin.sh)
- [Karabiner-Elements](https://karabiner-elements.pqrs.org)
- [Goku](https://github.com/yqrashawn/GokuRakuJoudo) (for Karabiner EDN)

### Fonts
- [Dank Mono](https://dank.sh) (primary)
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/) (fallback)

## 📁 Structure

```
.
├── .zshrc                    # Zsh configuration
├── zellij/                   # Zellij configs
│   ├── config.kdl           # Main config
│   ├── layouts/             # Custom layouts
│   ├── themes/              # Catppuccin themes
│   └── zellij-sessionizer.sh # Project switcher
├── ghostty/                  # Ghostty terminal
│   ├── config               # Main config
│   └── switch-theme.sh      # Theme switcher
├── atuin/                    # Shell history
│   ├── config.toml          # Main config
│   └── themes/              # Catppuccin themes
├── karabiner/                # Keyboard config
│   └── karabiner.edn        # Goku config
└── install.sh               # Installation script
```

## 🚀 Post-Installation

1. **Restart your terminal** or run `source ~/.zshrc`
2. **Install Zsh plugins**:
   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```
3. **Compile Karabiner config**: `goku`
4. **Start using the tools**:
   - Launch Zellij: `zj`
   - Search history: `Ctrl+r`
   - Switch projects: `Ctrl+f`

## 🤝 Contributing

Feel free to fork and customize! If you have improvements, PRs are welcome.

## 📄 License

MIT - Use freely and customize to your heart's content.

---

*Built with ❤️ and excessive attention to detail*