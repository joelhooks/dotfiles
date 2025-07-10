# Zellij Cheatsheet 🚀

## Core Concepts
- **Session**: A Zellij workspace (like tmux session)
- **Tab**: Collection of panes (like tmux window)
- **Pane**: Terminal instance
- **Mode**: Current input mode (Normal, Pane, Tab, etc.)

## Modes & Navigation

| Mode | Enter | Purpose |
|------|-------|---------|
| Normal | Default | Regular terminal use |
| Locked | `Ctrl+g` | Disable Zellij keys |
| Pane | `Ctrl+p` | Pane management |
| Tab | `Ctrl+t` | Tab management |
| Resize | `Ctrl+n` | Resize panes |
| Move | `Alt+m` | Move panes |
| Scroll | `Alt+s` | Scroll buffer |
| Session | `Ctrl+o` | Session management |

**Exit any mode**: `Esc` (except Locked - use `Ctrl+g`)

## Essential Keybindings

### Global (from Normal mode)
- `Ctrl+q` - Quit Zellij
- `Alt+n` - New pane
- `Alt+h/j/k/l` - Navigate panes (←↓↑→)
- `Alt+[/]` - Previous/Next swap layout
- `Alt+f` - Toggle floating panes
- `Alt+1-9` - Go to tab 1-9
- `Alt+w` - Close tab
- `Alt+r` - Rename tab
- `Alt+i/o` - Move tab left/right

### Pane Mode (`Ctrl+p`)
- `n` - New pane
- `d` - New pane down
- `r` - New pane right
- `x` - Close pane
- `f` - Toggle fullscreen
- `z` - Toggle pane frames
- `w` - Toggle floating panes
- `e` - Toggle embed/float
- `c` - Rename pane
- `h/j/k/l` - Navigate panes

### Tab Mode (`Ctrl+t`)
- `n` - New tab
- `x` - Close tab
- `r` - Rename tab
- `h/l` or `←/→` - Navigate tabs
- `Tab` - Toggle last tab
- `1-9` - Go to tab number
- `s` - Sync tab input
- `b` - Break pane to new tab
- `[/]` - Break pane left/right

### Resize Mode (`Ctrl+n`)
- `h/j/k/l` - Increase size in direction
- `H/J/K/L` - Decrease size in direction
- `+/=` - Increase size
- `-` - Decrease size

### Scroll Mode (`Alt+s`)
- `j/k` - Scroll down/up
- `d/u` - Half page down/up
- `Ctrl+f/b` - Page down/up
- `s` - Enter search
- `e` - Edit scrollback in $EDITOR

### Session Mode (`Ctrl+o`)
- `d` - Detach session
- `w` - Session manager
- `p` - Plugin manager
- `c` - Configuration

## Custom Aliases (from .zshrc)

```bash
zj              # Start Zellij
zja             # Attach to session
zjl             # List sessions
zjk             # Kill session
zjka            # Kill all sessions
zjd             # Start with dev layout
zs              # Session switcher
Ctrl+f          # Launch sessionizer
```

## Layouts

### Default Layout
- Single pane with tab/status bars

### Dev Layout (`zjd`)
```
┌─────────────┬──────────┐
│             │ Terminal │
│   Editor    ├──────────┤
│    (70%)    │   Logs   │
└─────────────┴──────────┘
 [code] [git] [server]
```

## Command Line

```bash
# Sessions
zellij                              # Start new session
zellij --session name               # Named session
zellij attach name                  # Attach to session
zellij list-sessions               # List all sessions
zellij kill-session name           # Kill specific session
zellij kill-all-sessions           # Kill all sessions

# Layouts
zellij --layout default            # Use default layout
zellij --layout dev                # Use dev layout
zellij --layout /path/to/layout    # Custom layout

# Actions
zellij action new-pane             # Create new pane
zellij action write "text"         # Write to focused pane
zellij action rename-tab "name"    # Rename current tab

# Config
zellij setup --check               # Check config
zellij setup --dump-config         # Show default config
```

## Tips & Tricks

1. **Project Sessions**: Use sessionizer (`Ctrl+f`) to create per-project sessions
2. **Persistent Sessions**: Sessions survive disconnection (auto-serialized)
3. **Copy Mode**: In scroll mode, select text with mouse (copy-on-select enabled)
4. **Floating Panes**: `Alt+f` for temporary overlay panes
5. **Sync Input**: In tab mode, press `s` to type in all panes
6. **Quick Rename**: `Alt+r` to rename tabs on the fly

## Configuration Locations

- Config: `~/.config/zellij/config.kdl`
- Layouts: `~/.config/zellij/layouts/`
- Themes: `~/.config/zellij/themes/`
- Sessionizer: `~/.config/zellij/zellij-sessionizer.sh`

## Current Theme
**Catppuccin Macchiato** 🎨

Switch themes by editing `theme` in config.kdl:
- `catppuccin-latte` (Light)
- `catppuccin-frappe` (Medium)
- `catppuccin-macchiato` (Current)
- `catppuccin-mocha` (Dark) 