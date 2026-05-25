# Joel's Dotfiles 🚀

> Joel's executable macOS machine profile: shell, terminal, editor, keyboard, and agent setup without the private-token footgun.

![Catppuccin Mocha](https://img.shields.io/badge/theme-catppuccin%20mocha-purple?style=for-the-badge)
![Zsh](https://img.shields.io/badge/shell-zsh-green?style=for-the-badge)
![macOS](https://img.shields.io/badge/os-macOS-blue?style=for-the-badge)

## 🎨 Preview

This setup features:
- **Catppuccin Mocha/Macchiato** dark theme across the terminal stack
- **1 million line** scrollback in Ghostty
- **GPU-accelerated** terminal rendering
- **Fuzzy history search** with workspace/directory filtering
- **Advanced keyboard customization** with Karabiner
- **Session persistence** with Zellij
- **Agent-facing maintenance docs** for safely extending the machine setup

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

### [Neovim](nvim/) - Text Editor
- kickstart.nvim base (minimal, understandable)
- Catppuccin theme
- Oil.nvim file explorer (edit filesystem like a buffer)
- Harpoon for instant file jumping (`Ctrl+1/2/3/4`)
- Telescope fuzzy finder
- LSP support with Mason
- Built-in cheatsheet (`<Space>?`)
- which-key for discovering keybinds

### [Karabiner](karabiner/) - Keyboard Customization
- Caps Lock → Escape/Control
- Home row modifiers
- Vim-style navigation
- App-specific shortcuts
- Emoji layer

### Agentic Machine Setup
- [AGENTS.md](AGENTS.md) tells agents how to maintain this repo without leaking local runtime sludge.
- [Machine Profile](docs/machine-profile.md) maps what belongs here vs what stays private.
- [Dotfiles Maintenance Skill](skills/dotfiles-maintenance/SKILL.md) is a portable skill for syncing, reviewing, and extending the setup.

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
- [Neovim Configuration](nvim/) - Editor keybindings
- [Karabiner Documentation](karabiner/) - Keyboard layers
- [Machine Profile](docs/machine-profile.md) - Agentic setup map
- [Dotfiles Maintenance Skill](skills/dotfiles-maintenance/SKILL.md) - Agent workflow for safe changes
- [Agent tool bootstrap check](scripts/bootstrap-agent-tools.sh) - verifies Pi/Codex/Claude/OpenCode/ShitRat/secrets/JoelClaw are present

## ⚡ Key Features

### Productivity Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+f` | Zellij project sessionizer |
| `Ctrl+r` | Atuin fuzzy history search |
| `Alt+1-9` | Quick tab switching |
| `Caps Lock` | Escape (tap) / Control (hold) |

### Neovim Shortcuts

| Shortcut | Action |
|----------|--------|
| `<Space>a` | Add file to harpoon |
| `<Space>h` | Open harpoon menu |
| `Ctrl+1/2/3/4` | Jump to harpooned file |
| `-` | Open file explorer (Oil) |
| `<Space>sf` | Find files |
| `<Space>sg` | Grep search |
| `<Space>sk` | Search keymaps |
| `<Space>?` | Show cheatsheet |

### Quick Commands

| Command | Description |
|---------|-------------|
| `zj` | Start Zellij |
| `zjh` | Start Zellij with home layout |
| `zjo` | Start Zellij with OpenCode layout |
| `zm` | Start phone-friendly Zellij session |
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
| `with-pi-llm <cmd>` | Run a command with a short-lived `PI_LLM_API_KEY` lease |
| `with-agent-axiom <cmd>` | Run a command with a short-lived Axiom token lease |

## 🎨 Theme Consistency

The terminal stack uses **Catppuccin dark variants** for a consistent look:

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
- [Neovim](https://neovim.io) (`brew install neovim`)
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
│   ├── layouts/             # Home, mobile, and OpenCode layouts
│   ├── themes/              # Optional Catppuccin themes
│   └── zellij-sessionizer.sh # Project switcher
├── ghostty/                  # Ghostty terminal
│   ├── config               # Main config
│   └── switch-theme.sh      # Theme switcher
├── atuin/                    # Shell history
│   ├── config.toml          # Main config
│   └── themes/              # Catppuccin themes
├── karabiner/                # Keyboard config
│   └── karabiner.edn        # Goku config
├── nvim/                     # Neovim config
│   └── init.lua             # kickstart.nvim based
├── docs/                     # Machine profile and setup notes
├── skills/                   # Agent skills for maintaining this setup
├── scripts/                  # Doctor and agent-tool check helpers
├── AGENTS.md                 # Agent instructions for this repo
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