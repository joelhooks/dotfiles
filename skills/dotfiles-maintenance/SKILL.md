---
name: dotfiles-maintenance
description: Maintain Joel's macOS dotfiles as an agentic machine profile. Use when syncing configs from a live machine, adding Pi/Claude/Codex/ShitRat/JoelClaw setup docs, bootstrapping a new Joel-flavored machine, or reviewing dotfiles for secrets and local runtime leakage.
---

# Dotfiles Maintenance

This repo is Joel's executable machine taste. Keep it useful for a fresh machine and safe for a public repo.

## Sync from the current machine

```bash
./sync-from-system.sh
./scripts/doctor.sh
./scripts/bootstrap-agent-tools.sh
# Optional focused checks when relevant:
./scripts/bootstrap-git-gh.sh
./scripts/bootstrap-network-trust.sh
```

The doctor script runs syntax checks, Zellij config validation, JSON template validation, an obvious secret scan, and local runtime-file checks. The bootstrap checks verify focused parts of the machine without copying auth files.

## Secret rule

Never commit long-lived secret values. Put them in `secrets` and lease them only when needed.

Preferred shell patterns:

- `with-pi-llm <cmd>` for temporary `PI_LLM_API_KEY`
- `with-agent-axiom <cmd>` for temporary `AGENT_AXIOM_TOKEN`
- `with-huge-icons-npm <cmd>` for temporary `HUGE_ICONS_NPM_TOKEN`
- `load-*-secret [ttl]` only when the current interactive shell truly needs exports

Local/private exports belong in `~/.zshrc.local`, not `.zshrc`.

## Adding new machine config

1. Identify the real source path on the machine.
2. Decide if it is safe to publish directly, needs a redacted template, or belongs only in docs.
3. Add install, sync, bootstrap, and doctor paths together when relevant.
4. Update README, `docs/machine-profile.md`, or `docs/provisioning-backlog.md` when the user-facing setup changes.
5. Validate syntax and run a secret/local-metadata scan.

## Agent tooling configs

For Pi, Claude, Codex, ShitRat, JoelClaw, and similar tools:

- Prefer docs/templates/bootstrap scripts over raw copied live config.
- Never copy auth, caches, session logs, sqlite DBs, paste buffers, or outboxes.
- Parameterize local paths with `$HOME` or env vars.
- Keep safety/permission bypasses opt-in and private.

## Publish checklist

- [ ] `git status --short --untracked-files=all` contains only intended files.
- [ ] `.pi/`, `.brain/`, `BRAIN.md`, local review artifacts, and session outputs are ignored/untracked.
- [ ] Shell/config syntax checks pass.
- [ ] Every docs-mentioned layout/keybind/script either exists in repo or is clearly optional.
- [ ] Public commit is made as `shitratgit[bot]` when ShitRat has access.
