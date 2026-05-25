# ShitRat Personal Inbox Setup

This is the reusable setup shape for Joel machines. It intentionally avoids private inbox specifics, tokens, customer data, and runtime cache contents.

## Repo-backed agent skill

The `joels-inbox` skill is sourced from the private `dark-wizard` repo and installed into Pi, Claude, and Codex with symlinks.

Default paths:

- Source: `${DARK_WIZARD_DIR:-$HOME/Code/joelhooks/dark-wizard}/skills/joels-inbox/SKILL.md`
- Pi target: `${PI_SKILLS_DIR:-$HOME/.pi/agent/skills}/joels-inbox/SKILL.md`
- Claude target: `${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}/joels-inbox/SKILL.md`
- Codex target: `${CODEX_SKILLS_DIR:-$HOME/.codex/skills}/joels-inbox/SKILL.md`

Install or refresh all three:

```bash
./scripts/bootstrap-shitrat-inbox.sh
```

## Runtime cache sync

`~/.shitrat/inbox/**` is runtime cache and receipts. It is not git material.

Use `rsync` over the fastest trusted peer path, usually Thunderbolt/link-local IPv6 or a local hostname. Configure the peer at runtime instead of baking private hostnames/IPs into dotfiles:

```bash
SHITRAT_CACHE_REMOTE='joel@peer-host.local' \
SHITRAT_CACHE_REMOTE_PATH='~/.shitrat' \
./scripts/sync-shitrat-cache.sh push
```

Or pull from another machine:

```bash
SHITRAT_CACHE_REMOTE='joel@source-host.local' \
SHITRAT_CACHE_REMOTE_PATH='~/.shitrat' \
./scripts/sync-shitrat-cache.sh pull
```

The sync script only moves the local `.shitrat` cache tree. It does not install secrets, mutate Front/Gmail, or refresh inbox snapshots.

## Fresh-machine checklist

1. Clone/pull `dark-wizard`, `shitrat`, and `dotfiles`.
2. Ensure `$HOME/.brain` points at `dark-wizard/.brain`.
3. Run `./scripts/bootstrap-shitrat-inbox.sh` from this repo to link Pi, Claude, and Codex skills.
4. Sync `.shitrat` cache with `./scripts/sync-shitrat-cache.sh pull` or `push` using env vars.
5. Run no-mutation smoke checks only:
   - `shitrat inbox rules export`
   - `shitrat inbox snapshot --profile joel-combined --metadata-only` only when it is cache-safe; do not use `--refresh` without approval.

## Machine-specific private config repo

If a machine needs durable private wiring beyond this public setup shape, create a private repo such as `joelhooks/shitrat-blaine` and symlink from it. Keep public `dotfiles` as the reusable installer/docs layer; keep private hostnames, local profile JSON, machine inventory, and ShitRat cache shape in the private repo. Do not commit raw inbox cache or tokens there either.

## Safety

Never commit:

- raw `~/.shitrat/inbox/**` cache data,
- Front/Gmail tokens or secret names,
- customer/support metadata,
- Pi sessions, notes bridge state, or auth files.
