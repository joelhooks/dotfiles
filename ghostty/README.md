# Ghostty Cheatsheet 👻

## What is Ghostty?
A fast, feature-rich terminal emulator written in Zig with native GPU acceleration.

## Current Theme
**Catppuccin Macchiato** 🎨 (aligned with Atuin & Zellij)

## Essential Keybindings

### Tab Management
| Key | Action |
|-----|--------|
| `Cmd+T` | New tab |
| `Cmd+W` | Close tab |
| `Cmd+H` | Previous tab |
| `Cmd+L` | Next tab |
| `Cmd+1-9` | Go to tab 1-9 |
| `Cmd+Shift+T` | New window |

### Split Management
| Key | Action |
|-----|--------|
| `Cmd+D` | Split right |
| `Cmd+Shift+D` | Split down |
| `Cmd+/` | Auto split |
| `Ctrl+H/J/K/L` | Navigate splits |
| `Cmd+Enter` | Toggle split zoom |
| `Cmd+Ctrl+H/J/K/L` | Resize splits |

### Quick Actions
| Key | Action |
|-----|--------|
| `Cmd+R` | Reload config |
| `Cmd+Shift+F` | Toggle fullscreen |
| `Shift+Enter` | Insert newline |

### Scrolling
Use mouse/trackpad for scrolling. Ghostty has excellent native scrolling support with the 1M line buffer!

## Configuration

### Config Location
```
~/Library/Application Support/com.mitchellh.ghostty/config
```

### Key Settings

#### Typography
```
font-family = Dank Mono
font-size = 20
font-thicken = true
```

#### Theme & Appearance
```
theme = catppuccin-macchiato
background-opacity = 0.97
background-blur-radius = 25
macos-titlebar-style = transparent
```

#### Performance
```
scrollback-limit = 1000000  # 1 MILLION lines!
shell-integration = zsh
copy-on-select = clipboard
```

## Tips & Tricks

### 1. Split Workflows
- Use `Cmd+D` for side-by-side editor/terminal
- `Cmd+Enter` to focus on one split temporarily
- Navigate with vim keys: `Ctrl+H/J/K/L`

### 2. Tab Organization
- Name tabs by context (project, server, etc.)
- Use `Cmd+1-9` for quick switching
- Keep consistent tab order across sessions

### 3. Integration with Zellij
When using Ghostty with Zellij:
- Ghostty handles window/tab management
- Zellij handles session/pane management
- Use Ghostty for GUI features, Zellij for persistence

### 4. Copy & Paste
- Select text to auto-copy
- `Cmd+V` to paste
- No clipboard protection for smooth workflow

### 5. Performance Tuning
- GPU accelerated rendering
- **1 MILLION line scrollback buffer** 🚀
- Optimized for Retina displays
- ~100MB RAM per terminal (worth it!)

## Common Workflows

### Development Setup
```
1. Cmd+T         # New tab for project
2. Cmd+D         # Split for terminal
3. Ctrl+L        # Focus editor split
4. Cmd+Enter     # Zoom when needed
```

### Multi-Project
```
1. Cmd+T         # Tab per project
2. Cmd+1/2/3     # Quick switch
3. Cmd+Shift+T   # New window for different context
```

### Debugging
```
1. Cmd+F         # Search output
2. Cmd+Shift+H   # Jump to top
3. Cmd+K         # Clear for fresh start
```

## Ghostty vs Other Terminals

| Feature | Ghostty | iTerm2 | Alacritty |
|---------|---------|--------|-----------|
| GPU Rendering | ✅ Native | ❌ | ✅ |
| Splits | ✅ Built-in | ✅ | ❌ |
| Tabs | ✅ Native | ✅ | ❌ |
| Config | ✅ Simple | ❌ Complex | ✅ |
| Performance | 🚀 Fastest | 🐌 | 🚀 |
| macOS Native | ✅ | ✅ | ❌ |

## Shell Integration

Ghostty automatically integrates with:
- **Cursor tracking** - Knows where cursor is
- **Sudo detection** - Shows when in sudo
- **Title updates** - Dynamic window titles
- **OSC sequences** - Full support

## Troubleshooting

### Config Not Loading?
```bash
ghostty +validate-config
```

### Performance Issues?
- Check GPU acceleration: `ghostty +show-config | grep gpu`
- Reduce scrollback limit if needed
- Disable transparency/blur

### Font Rendering?
- Adjust `font-thicken` setting
- Try different `adjust-cell-height` values
- Check font installation

## Resources

- [Ghostty Docs](https://ghostty.org/docs)
- [Config Reference](https://ghostty.org/docs/config)
- [Catppuccin Themes](https://github.com/catppuccin/ghostty) 