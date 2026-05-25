# Joel's Dotfiles Agent Guide

This repo is the machine-shape source for Joel's macOS development setup. Treat it like an executable taste profile, not a random config dump.

## What belongs here

- Reproducible config for shell, terminal, editor, multiplexer, keyboard, and agent tooling.
- Sanitized install/sync scripts that make a new machine feel like Joel's machine.
- Agent-facing docs and skills that explain how to maintain the setup safely.
- Templates and bootstrap scripts for Pi, Claude, Codex, ShitRat, JoelClaw, and related tools.

## What does not belong here

- Raw secrets, tokens, private keys, cert bodies, auth files, local session logs, model transcripts, or support/customer data.
- Whole private agent prompts copied from `~/.pi`, `~/.claude`, or `~/.codex` without review.
- Machine-local caches like `.pi/`, run history, sqlite DBs, paste caches, notes-bridge state, or outboxes.
- Private/global Brain material. Project `.brain/` and `BRAIN.md` are allowed here only when they describe this public dotfiles repo and pass the secret scan.

Secrets go in `secrets` / agent-secrets and are leased only when a command needs them. Local one-offs go in `~/.zshrc.local`, which is intentionally gitignored.

## Standard sync workflow

When updating from the current machine:

```bash
./sync-from-system.sh
./scripts/doctor.sh
./scripts/bootstrap-agent-tools.sh
# Optional focused checks when relevant:
./scripts/bootstrap-git-gh.sh
./scripts/bootstrap-network-trust.sh
```

If the change touches public docs, make sure the README matches the actual installed files. If the change touches Zellij keybinds, every referenced file or command must either be committed or documented as optional. If the change adds a bootstrap concern, add the doctor/syntax path too.

## Commit/publish rules

- Prefer small, boring commits with Conventional Commit prefixes.
- Agent-authored GitHub writes should use ShitRat when the GitHub App has repo access.
- Never `git add -A` blindly after running tools that create `.pi/`, review output, or session artifacts. Project `.brain/` files are okay when intentionally curated.
- Before publishing public dotfiles, run a staged diff review focused on secrets and machine-local metadata.

## Machine taste rules

- Bootstrap scripts should be idempotent and non-destructive unless the name clearly says it applies settings.
- Fast shell startup beats ornamental shell ceremony.
- Terminal UX should preserve scrollback and make panes/tabs boringly easy.
- Atkinson/Geist/Atuin/Zellij/Ghostty/Neovim choices should serve readability and flow, not screenshot cosplay.
- Keep helpers discoverable in README/docs, but put private workflows behind `~/.zshrc.local` or `secrets lease`.
- If a config is Joel-specific but useful on a fresh Joel machine, parameterize it with env vars instead of hardcoding local paths.
