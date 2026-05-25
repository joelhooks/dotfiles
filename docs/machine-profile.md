# Joel Machine Profile

This is the map for turning a fresh macOS box into Joel's working machine without copying private sludge.

## Core stack

- **Shell:** Zsh, Oh My Zsh, Pure prompt, `fnm`, Bun, pnpm.
- **Navigation/search:** `zoxide`, `fd`, `fzf`, `eza`, `bat`, Atuin.
- **Terminal:** Ghostty with Catppuccin Mocha, 1M scrollback, split/tab keybinds.
- **Mux:** Zellij with `home`, `mobile`, and `opencode` layouts plus keycoach drills.
- **Editor:** Neovim config under `nvim/` with lazy lockfile.
- **Keyboard:** Karabiner/Goku config.
- **Agent tools:** Pi, Claude Code, Codex, OpenCode, ShitRat, JoelClaw, agent-secrets.

## Secret handling

The shell should not export long-lived tokens at startup.

Current on-demand leases in `.zshrc`:

- `with-pi-llm <cmd>` / `load-pi-llm-secret [ttl]`
- `with-agent-axiom <cmd>` / `load-agent-axiom-secret [ttl]`
- `with-huge-icons-npm <cmd>` / `load-huge-icons-npm-token [ttl]`

Backed by `secrets` names:

- `PI_LLM_API_KEY`
- `AGENT_AXIOM_TOKEN`
- `HUGE_ICONS_NPM_TOKEN`

Keep non-secret defaults like `PI_LLM_MODEL` in `.zshrc`. Keep customer/project credentials in `secrets` or `~/.zshrc.local`.

## Agent config candidates

Useful candidates for future dotfiles work, but sanitize before committing:

- `~/.pi/agent/settings.json` as a redacted template, not the live auth/config blob.
- `~/.pi/agent/APPEND_SYSTEM.md` as selected public rules only, not private operating memory.
- `~/.codex/AGENTS.md` and `~/.codex/config.toml` as templates with private paths/secrets removed.
- `~/.claude/settings.json` and hooks as templates, excluding caches, paste buffers, session env, and auth.
- `~/.agents/memory/*.md` only when the note is generally useful and not private/customer-specific.
- JoelClaw install/bootstrap docs, not `.joelclaw/outbox` or runtime state.

## Bootstrap shape worth building next

A useful fresh-machine flow should be boring:

1. Install Homebrew packages and GUI apps.
2. Clone `joelhooks/dotfiles`.
3. Run `./install.sh`.
4. Install/doctor Pi, Claude, Codex, ShitRat, JoelClaw, and `secrets`.
5. Restore only named secrets via `secrets`, never raw `.env` dumps.
6. Run `./scripts/doctor.sh` and `./scripts/bootstrap-agent-tools.sh` to check commands, symlinks, Zellij config, shell syntax, agent CLIs, and ignored private paths.

## Red lines

- Do not commit `.pi/`, `.brain/`, `BRAIN.md`, `.claude` caches, `.codex` DBs, or `.joelclaw/outbox`.
- Do not hardcode Tailscale IPs, local ports, or repo paths in public config unless they are parameterized.
- Do not make public install scripts disable permission prompts or bypass safety gates by default.
