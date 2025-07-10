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
- `↑/↓` or `j/k` - Navigate results
- `PageUp/PageDown` - Page through results
- `Ctrl+u/d` - Half page up/down
- `Home/End` - Jump to start/end

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
search_mode = "fuzzy"          # fuzzy, prefix, fulltext
filter_mode = "global"         # global, host, session, directory
inline_height = 15             # Search UI height

# UI
style = "compact"              # auto, full, compact
show_preview = true            # Show command preview
invert = false                 # Search bar position
show_help = false              # Show help text

# History
history_filter = [...]         # Regex filters
secrets_filter = true          # Filter secrets
enter_accept = true            # Enter runs command

# Performance  
sync_frequency = "30m"         # Sync interval
auto_sync = true               # Enable auto sync
update_check = false           # Disable update checks
```

### Custom Aliases (from .zshrc)
```bash
h               # Quick history search
hs              # History statistics  
hd              # Delete history entry
ht              # Theme switcher
```

## Filter Modes

1. **Global** - All commands from all time
2. **Host** - Only from current machine
3. **Session** - Current shell session only
4. **Directory** - Current directory only
5. **Workspace** - Current git repository

**Switch modes**: Use Ctrl+g/h/s/d/w during search

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