# Zellij Key Shit (Joel's config)

This is based on `~/.config/zellij/config.kdl` (not Zellij defaults).

## Fast Help

- Built-in config UI (shows keybinds): `Alt /`
- This cheat sheet: `F1`
- Key drill (spaced repetition): `F2`
- Key drill (nvim): `F3`
- Reverse drill (zellij): `F4`
- Reverse drill (nvim): `F5`
- Lock/unlock: `Ctrl g`
- Quit: `Ctrl q`

## Sessions (Session mode: `Ctrl o`)

- Session mode: `Ctrl o`
- Detach (leave session running): `Ctrl o` then `d`
- Session manager UI: `Ctrl o` then `w`
- Configuration UI: `Ctrl o` then `c`
- Plugin manager: `Ctrl o` then `p`
- About: `Ctrl o` then `a`

## Tabs (Tab mode: `Ctrl t`)

- Tab mode: `Ctrl t` (use `Esc` to bail back to normal)
- New tab: `Ctrl t` then `n`
- Close tab: `Ctrl t` then `x`
- Rename tab: `Ctrl t` then `r`
- Prev tab: `Ctrl t` then `h` or `k` (or `Left`/`Up`)
- Next tab: `Ctrl t` then `l` or `j` (or `Right`/`Down`)
- Jump to tab N: `Ctrl t` then `1..9`
- Toggle last tab: `Ctrl t` then `Tab`
- Sync panes in tab: `Ctrl t` then `s`

## Panes (Pane mode: `Ctrl p`)

- Pane mode: `Ctrl p`
- New pane: `Ctrl p` then `n`
- Split down: `Ctrl p` then `d`
- Split right: `Ctrl p` then `r`
- Close focused pane: `Ctrl p` then `x`
- Fullscreen focused pane: `Ctrl p` then `f`
- Toggle floating panes: `Ctrl p` then `w`
- Float/embed focused pane: `Ctrl p` then `e`
- Rename pane: `Ctrl p` then `c`
- Focus move: `Ctrl p` then `h/j/k/l` (or arrow keys)

## Scrollback (Scroll mode: `Ctrl s`)

- Scroll mode: `Ctrl s`
- Search: `s` (while in scroll mode)
- Edit scrollback in `$EDITOR`: `e` (while in scroll mode)
- Scroll: `j/k` (or arrow keys)
- Page: `PageUp/PageDown` or `Ctrl b` / `Ctrl f`
- Half page: `u` / `d`
- Back to live + exit: `Ctrl c`
- Exit scroll mode: `Ctrl s`

## Resize/Move

- Resize mode: `Ctrl n` (use `h/j/k/l` or arrows, `+/-`)
- Move mode: `Ctrl h` (use `h/j/k/l` or arrows)

## Tmux-ish Mode (`Ctrl b`)

- Tmux mode: `Ctrl b`
- Scrollback: `Ctrl b` then `[`
- Split down: `Ctrl b` then `"`
- Split right: `Ctrl b` then `%`
- New tab: `Ctrl b` then `c`
- Next/prev tab: `Ctrl b` then `n` / `p`

## Global Alt Keys (no mode switching)

- Focus/tab edge: `Alt h/l` or `Alt Left/Right`
- Focus down/up: `Alt j/k` or `Alt Down/Up`
- New pane: `Alt n`
- Toggle floating: `Alt f`
- Resize: `Alt +` / `Alt -`
- Move tab left/right: `Alt i` / `Alt o`

## Ctrl-S Freeze Fix (XON/XOFF)

If `Ctrl s` stops output (looks like the terminal froze):

- Run: `stty -ixon`
- Make it permanent: add `stty -ixon` to your `~/.zshrc` so every shell disables software flow control.
