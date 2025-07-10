# ZSH Configuration Cheat Sheet

## 🔥 Key Features

### Navigation
- `z <partial-path>` - Jump to frecent directories (e.g., `z Code`)
- `..` / `...` / `....` - Go up directories
- `-` - Go to previous directory
- `dev` - Jump to ~/Code

### File Operations
- `mkd <dirname>` - Create directory and cd into it
- `extract <archive>` - Extract any archive format (.zip, .tar.gz, etc.)
- `tre` - Better tree view (excludes node_modules, .git, etc.)

### macOS Specific
- `showfiles` - Show hidden files in Finder
- `hidefiles` - Hide hidden files in Finder
- `flushdns` - Clear DNS cache
- `afk` - Lock screen
- `cleanup` - Remove all .DS_Store files
- `emptytrash` - Empty all trash cans

### Git Shortcuts
- `gst` - Git status (short format)
- `glog` - Git log with graph
- `gdiff` - Git diff with color words
- `gclean` - Clean and reset working directory
- `gnuke` - Hard reset and clean everything

### Development
- `v` - Open neovim
- `c` - Open cursor
- `p` - Run pnpm
- `px` - Run pnpm dlx
- `pdev` - Run pnpm dev
- `pbuild` - Run pnpm build
- `ptest` - Run pnpm test

### Docker
- `dps` - Better docker ps format
- `dclean` - Clean all docker resources
- `dstop` - Stop all containers
- `drm` - Remove all containers

## ⚡ Power Features

### FZF (Fuzzy Finder)
- `Ctrl+R` - Search command history
- `Ctrl+T` - Search files in current directory
- `Alt+C` - Change to directory

### Autosuggestions
- Type commands and see suggestions in gray
- Press `→` to accept suggestion
- Press `Ctrl+→` to accept partial suggestion

### Syntax Highlighting
- Commands turn green when valid
- Red when invalid
- Strings and arguments are colored

## 💡 Tips
- Create `~/.zshrc.local` for machine-specific configs
- History is deduplicated and synced between sessions
- Use space before commands to exclude from history
