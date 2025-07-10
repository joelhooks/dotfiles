# Atuin Cheatsheet 🔥

## What is Atuin?
Magical shell history that syncs across machines, with smart search and statistics.

## Core Features
- **Fuzzy Search**: Find commands instantly
- **Context Awareness**: Filter by directory, host, session
- **Statistics**: Track command usage
- **Sync**: Optional cross-machine history
- **Privacy**: Client-side encryption

## Keybindings

### Search Mode (`Ctrl+r` or `↑`)
| Key | Action |
|-----|--------|
| `Ctrl+r` | Open fuzzy search |
| `↑` | Context-aware history (directory) |
| `Enter` | Execute selected command |
| `Tab` | Copy to shell for editing |
| `Ctrl+o` | Open inspector |
| `Ctrl+d` | Delete entry |
| `Esc` | Exit search |

### Navigation
- `↑/↓` or `j/k` - Navigate results (won't exit at boundaries)
- `PageUp/PageDown` - Page through results
- `Ctrl+u/d` - Half page up/down
- `Home/End` - Jump to start/end
- `←` - Move cursor (won't exit search)
- `→` - Accept line (same as Tab)
- `Ctrl+1-9` - Quick shortcuts (macOS friendly)

### Filters (during search)
- `Ctrl+h` - Filter: host
- `Ctrl+s` - Filter: session  
- `Ctrl+d` - Filter: directory
- `Ctrl+w` - Filter: workspace
- `Ctrl+g` - Filter: global (all)
- `Ctrl+i` - Invert search

## Command Line

### Search & History
```bash
atuin search                    # Interactive search
atuin search --cmd "git"       # Search for commands
atuin search --before 2d       # Commands from 2 days ago
atuin search --limit 50        # Limit results
h                              # Alias for search (custom)

atuin history list             # List all history
atuin history last             # Last command
atuin history delete <id>      # Delete entry
hd                             # Alias for delete (custom)
```

### Statistics
```bash
atuin stats                    # Overall statistics
atuin stats day                # Today's stats
atuin stats week               # This week's stats
hs                             # Alias for stats (custom)

# Examples
atuin stats | head -20         # Top 20 commands
atuin stats day --cmd git      # Git commands today
```

### Sync (Optional)
```bash
atuin register                 # Create account
atuin login                    # Login to sync
atuin logout                   # Stop syncing
atuin sync                     # Manual sync
atuin key                      # Show encryption key
```

### Import History
```bash
atuin import bash              # Import from bash
atuin import zsh               # Import from zsh
atuin import fish              # Import from fish
atuin import auto              # Auto-detect shell
```

## Configuration

### Key Settings (in config.toml)
```toml
# Search
search_mode = "fuzzy"                      # fuzzy, prefix, fulltext
filter_mode = "global"                     # Default filter mode
filter_mode_shell_up_key_binding = "directory"  # Up arrow uses directory context
workspaces = true                          # Git workspace awareness enabled
inline_height = 0                          # Maximum visibility (full screen)

# UI
style = "auto"                             # Adaptive layout
show_preview = true                        # Show command preview
max_preview_height = 20                    # See lots more context
invert = false                             # Search bar at bottom
show_help = false                          # Cleaner UI
show_tabs = true                           # Show search/inspect tabs

# Navigation
ctrl_n_shortcuts = true                    # Use Ctrl+1-9 (better for macOS)
scroll_exits = false                       # Keep browsing at boundaries
exit_past_line_start = false               # Don't exit on left arrow

# History
history_filter = [                         # Comprehensive filters
  # Security
  "^secret", "password=", "token=", "api_key=",
  # Noise
  "^ls$", "^cd$", "^pwd$", "^exit$",
  # Typos
  "^[^a-zA-Z]", "^\\s"
]
secrets_filter = true                      # Auto-filter secrets
enter_accept = true                        # Enter runs command

# Performance  
sync_frequency = "30m"                     # Sync interval
auto_sync = true                           # Enable auto sync
update_check = false                       # Manual update checks
local_timeout = 2                          # Fast local DB
```

### Custom Aliases (from .zshrc)
```bash
h               # Quick history search
hs              # History statistics  
hd              # Delete history entry
ht              # Theme switcher
```

## Filter Modes

Default filter priority order:
1. **Workspace** - Current git repository (when in a repo)
2. **Directory** - Current directory only (default for ↑ arrow)
3. **Global** - All commands from all time
4. **Host** - Only from current machine
5. **Session** - Current shell session only

**Switch modes**: Use Ctrl+w/d/g/h/s during search

**Note**: Up arrow uses directory filter by default for context-aware history!

## Search Syntax

### Fuzzy Search (default)
- `gco` finds `git checkout`
- `dcup` finds `docker-compose up`

### Operators
- `^term` - Starts with
- `term$` - Ends with
- `!term` - Exclude term
- `term1 term2` - Both terms

### Time Filters
- `--before 1d` - Before 1 day ago
- `--after 2w` - After 2 weeks ago
- `--limit 100` - Limit results

## Current Theme

**Catppuccin Macchiato Mauve** 🎨

### Switch Themes
Run `ht` to switch between:
1. Mauve (purple) - Current
2. Blue
3. Green  
4. Pink

## Tips & Tricks

1. **Quick Re-run**: Press `↑` for directory-specific history
2. **Edit Before Run**: Press `Tab` instead of `Enter`
3. **Clean History**: Use regex filters to exclude noise
4. **Project Context**: Workspace mode for git repos
5. **Privacy**: Passwords auto-filtered, add custom filters
6. **Speed**: Indexes 1M+ commands instantly

## Stats Insights

```bash
# Most used commands
atuin stats | head -10

# Commands by day of week
atuin stats day

# Specific command usage
atuin stats --cmd docker

# Time-based analysis  
atuin stats --before 1w --after 2w
```

**Enhanced subcommand tracking** for:
- git, docker, npm, pnpm, yarn
- kubectl, terraform, aws, gcloud, az
- brew, cargo, go, gh, vercel
- systemctl, tmux, apt, dnf, nix

## Troubleshooting

```bash
# Check database
atuin doctor

# Database location
~/.local/share/atuin/history.db

# Config location
~/.config/atuin/config.toml

# Clear search cache
rm -rf ~/.local/share/atuin/cache
```

## Privacy Features

- Local-first (sync optional)
- Client-side encryption
- Automatic secret filtering
- Custom filter patterns
- Directory-based filtering

## Advanced Usage

### Custom Filters
```toml
history_filter = [
    "^secret",
    "password=",
    "token=.*",
]

cwd_filter = [
    "/private/",
    "/tmp/",
]
```

### Integration
- Works with any shell
- Preserves existing history
- Non-invasive (can disable anytime)
- Supports command duration tracking 