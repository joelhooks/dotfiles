# Joel Machine Profile

This is the map for turning a fresh macOS box into Joel's working machine without copying private sludge.

## Core stack

- **Shell:** Zsh, Oh My Zsh, Pure prompt, `fnm`, Bun, pnpm.
- **Git/GitHub:** Joel identity, `main` as default branch, GitHub SSH protocol, ShitRat for agent-authored GitHub writes.
- **Navigation/search:** `zoxide`, `fd`, `fzf`, `eza`, `bat`, Atuin.
- **Terminal:** Ghostty with Catppuccin Mocha, 1M scrollback, split/tab keybinds.
- **Mux:** Zellij with `home`, `mobile`, and `opencode` layouts.
- **Editor:** Neovim config under `nvim/` with lazy lockfile.
- **Runtimes:** `fnm` current LTS Node, Corepack/pnpm, Bun, `uv`/Python 3.12.
- **Local data:** Postgres 17 and Valkey/Redis available, not forced always-on.
- **Cloud:** AWS CLI v2 with SSO config templates, `wrangler`, `vercel`, `gh`; credentials stay private.
- **Network trust:** Tailscale, `mkcert`, and portless trust checks.
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

## Provisioning backlog

See [Provisioning Backlog](provisioning-backlog.md) for the concrete next pieces and what's already scaffolded: Git/GitHub defaults, primary repo manifest, AWS templates, Redis/Postgres, `uv`/Python, `fnm` LTS Node, Mac defaults, and safe agent harness templates.

## Bootstrap shape worth building next

A useful fresh-machine flow should be boring:

1. Install Homebrew packages and GUI apps with `./scripts/bootstrap-macos.sh`.
2. Clone `joelhooks/dotfiles`.
3. Run `./install.sh`; it is safe to rerun after partial setup failures.
4. Apply Git/GitHub defaults with `./scripts/bootstrap-git-gh.sh`.
5. Install/update primary repos with `./scripts/bootstrap-repos.sh`.
6. Install runtimes with `./scripts/bootstrap-runtimes.sh`.
7. Install/doctor Pi, Claude, Codex, ShitRat, JoelClaw, and `secrets`.
8. Restore only named secrets via `secrets`, never raw `.env` dumps.
9. Run `./scripts/doctor.sh`, `./scripts/bootstrap-agent-tools.sh`, and the focused bootstrap checks you need.

## Red lines

- Do not commit `.pi/`, `.brain/`, `BRAIN.md`, `.claude` caches, `.codex` DBs, or `.joelclaw/outbox`.
- Do not hardcode Tailscale IPs, local ports, or repo paths in public config unless they are parameterized.
- Do not make public install scripts disable permission prompts or bypass safety gates by default.
