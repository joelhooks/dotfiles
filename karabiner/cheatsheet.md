# Karabiner Cheatsheet 🎮

## What is Karabiner?
Advanced keyboard customization for macOS. Your config uses Goku (EDN format) for cleaner configuration.

## Core Concepts
- **Layers**: Modifier keys that change keyboard behavior
- **Simlayers**: Keys that act as modifiers when held
- **Modes**: Temporary keyboard states

## Key Layers

### Caps Lock → Escape/Control
- **Tap**: Escape
- **Hold**: Left Control
- **Caps+A**: Actual Caps Lock

### Function Keys
- **F23**: Special modifier
- **F24**: Launch mode (alone = Option+Space)

## Simlayers (Hold Key)

### Home Row Modifiers
| Key | Simlayer | Description |
|-----|----------|-------------|
| `-` | fn-mode | Control + arrows |
| `A` | opt-mode | Option + arrows |
| `S` | shift-opt-mode | Shift+Option + arrows |
| `D` | shift-mode | Shift + arrows |
| `F` | movement-mode | Arrow keys |
| `G` | cursor-mode | Cursor manipulation |
| `J` | delete-mode | Delete operations |
| `K` | editor-mode | Editor navigation |

### Top Row
| Key | Simlayer | Description |
|-----|----------|-------------|
| `Q` | quick-mode | Quick actions |
| `W` | close-mode | Close operations |
| `E` | finder-mode | Finder shortcuts |
| `R` | peek-mode | Peek definitions |
| `T` | go-mode | Go to navigation |
| `P` | code-mode | Code actions |

### Bottom Row
| Key | Simlayer | Description |
|-----|----------|-------------|
| `Z` | emoji-mode | Emoji picker |
| `C` | command-mode | Command shortcuts |

## Essential Shortcuts

### Navigation (Movement Mode - Hold F)
- `F+H/J/K/L` → Arrow keys
- `F+Y` → Ctrl+Left (word left)
- `F+O` → Ctrl+Right (word right)

### Selection (Shift Mode - Hold D)
- `D+H/J/K/L` → Shift + arrows
- `D+Y` → Select word left
- `D+O` → Select word right

### Delete (Hold J)
- `J+S` → Backspace
- `J+D` → Delete forward
- `J+A` → Option+Backspace (delete word)
- `J+F` → Option+Delete (delete word forward)
- `J+Escape` → Delete line (in VS Code)

### Go To (Hold T)
- `T+O` → Go to definition
- `T+I` → Go to implementation
- `T+R` → Go to references
- `T+S` → Go to symbol
- `T+L` → Go to line

### Peek (Hold R)
- `R+H` → Peek definition
- `R+E` → Peek implementation
- `R+N` → Peek references

### Editor (Hold K)
- `K+A` → Previous editor tab
- `K+T` → Next editor tab
- `K+R` → Go back
- `K+S` → Go forward

### Spacebar Magic (Hold Space)
- `Space+A/S` → `[]` brackets
- `Space+D/F` → `()` parentheses
- `Space+J/K` → `{}` braces
- `Space+L/;` → `<>` angle brackets
- `Space+Q` → `()=> ` arrow function
- `Space+'` → `=""` attribute

### Numbers (Hold Tab)
- `Tab+A` → 1
- `Tab+S` → 2
- `Tab+D` → 3
- ... through `Tab+;` → 0

### Special Characters (; or .)
- `;/. + E` → `!` exclamation
- `;/. + A` → `@` at
- `;/. + H` → `#` hash
- `;/. + D` → `$` dollar
- `;/. + P` → `%` percent
- `;/. + C` → `^` caret
- `;/. + S` → `&` ampersand
- `;/. + B` → `*` asterisk

### Emoji (Hold Z)
- `Z+E` → Emoji picker
- `Z+B` → 😊 blush
- `Z+F` → 🔥 fire
- `Z+H` → 😍 heart-eyes
- `Z+J` → 😂 joking
- `Z+L` → ❤️ love
- `Z+M` → 🤯 mind blown
- `Z+P` → 🎉 party

### Launch Apps (Hold L)
- `L+C` → VS Code (via Alfred)
- `L+D` → Discord
- `L+F` → Finder
- `L+G` → Google Chrome
- `L+S` → Slack
- `L+T` → iTerm
- `L+K` → Restart Karabiner

### Escape Mode Shortcuts
- `Esc+T` → Todo pad
- `Esc+A` → App launcher
- `Esc+C` → Auto center app
- `Esc+N` → Journal
- `Esc+W` → Wiki

## App-Specific

### VS Code
- `Cmd` (tap) → Go to file
- `Ctrl` (tap) → Command palette
- `W+A` → Close all
- `W+O` → Close others

### Chrome
- `Cmd` (tap) → New tab (Ctrl+T)
- `D` (with 2 fingers) → Dev tools

## Pro Tips

1. **Hyper Key**: Your config uses Command+Shift+Control+Option as "hyper"
2. **Escape Resets**: Pressing Escape clears all stuck modes
3. **Vim Navigation**: H/J/K/L work in most layer modes
4. **Context Aware**: Different apps have different shortcuts

## Troubleshooting

### Stuck Mode?
Press `Escape` to reset all modes

### Restart Karabiner
Press `L+K` (Launch mode + K)

### View Current Config
The config is at `~/.config/karabiner.edn` 