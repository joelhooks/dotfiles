# Provisioning Backlog

This is the backlog for making `joelhooks/dotfiles` a real fresh-machine builder instead of a pretty config scrapbook.

## First-pass scaffolds now in repo

- `Brewfile` for CLI packages, casks, fonts, runtimes, local services, and cloud tools.
- `git/gitconfig` plus `scripts/bootstrap-git-gh.sh` for Git/GitHub defaults.
- `manifests/repos.tsv` plus `scripts/bootstrap-repos.sh` for primary repo clone/update.
- `aws/config.example` plus `scripts/bootstrap-aws.sh` for SSO/profile shape.
- `scripts/bootstrap-runtimes.sh` for `fnm` LTS Node, Corepack/pnpm, Bun, `uv`/Python.
- `scripts/bootstrap-dev-services.sh` for Postgres 17 and Valkey/Redis.
- `scripts/bootstrap-network-trust.sh` for Tailscale, `mkcert`, and portless trust checks.
- `templates/` plus `scripts/bootstrap-agent-templates.sh` for public-safe Pi/Codex/Claude/zsh local examples.
- `docs/secrets-registry.md` for secret names/purpose without values.

## Tier 0: should be public and reproducible

### Git + GitHub defaults

- Global Git identity: `Joel Hooks <joelhooks@gmail.com>`.
- `init.defaultBranch = main`.
- GitHub CLI uses SSH for git operations.
- Conventional Commit messages by default.
- Agent-authored GitHub writes should use `shitratgit[bot]` when the app has repo access.
- Keep the public-safe `git/gitconfig` template free of credentials and machine-only include paths.

### Primary repo manifest

Use the manifest-driven clone/update script instead of scattering repo paths through shell aliases.

Start with stable roots:

- `~/Code/joelhooks/dotfiles`
- `~/Code/joelhooks/dark-wizard`
- `~/Code/joelhooks/pi-mono`
- `~/Code/joelhooks/pi-tools`
- `~/Code/joelhooks/pi-notes`
- `~/Code/joelhooks/pi-cmux`
- `~/Code/joelhooks/pi-feedback`
- `~/Code/joelhooks/shitrat-cli`
- `~/Code/joelhooks/joelclaw`
- `~/Code/badass-courses/second-brain`

Private/customer/course repos should be in a manifest with repo names only, not secrets or local runtime state.

### Node / Bun / package managers

- `fnm` is the Node manager.
- Default Node should be current LTS, not random project drift.
- Enable/use Corepack where it helps, but keep `pnpm` explicit because most active repos use it.
- Bun is the global JS CLI toolchain and should stay early enough on PATH for Bun-installed CLIs.
- Doctor/bootstrap should verify: `node`, `fnm`, `pnpm`, `bun`, `corepack`.

### Python / uv

- `uv` is the default Python tool/project runner.
- Prefer `uvx` for one-off tools instead of global pip sludge.
- Add `pipx` only if a tool truly wants it.
- Doctor/bootstrap should verify `uv` and a sane Python 3.

### Local data services

Modern local services should be easy but not always-on unless asked.

- Postgres: install modern `postgresql@17` or use OrbStack/Docker Compose for project-local DBs.
- Redis: install modern `redis` CLI/server or use containerized Redis per project.
- Keep helper docs/scripts for starting/stopping/checking local Postgres/Valkey/Redis.
- Prefer project-local `.env.local` from `secrets env` over global DB passwords.

### AWS + cloud CLIs

- AWS CLI v2 and SSO/profile setup belongs here as templates/docs, not raw credentials.
- Add public-safe examples for `~/.aws/config` profiles and region defaults.
- Never commit `~/.aws/credentials`, SSO cache, or session tokens.
- Also track common CLIs: `vercel`, `wrangler`, `gh`, `linear`/tracker tooling if used.

### Mac baseline

- Xcode Command Line Tools.
- Homebrew `Brewfile` for CLI packages and casks.
- Fonts: Dank Mono, JetBrains Mono, Atkinson Hyperlegible, SF Symbols if needed.
- macOS defaults worth preserving: keyboard repeat, hidden files, screenshots folder, Dock/Finder sanity.
- Tailscale installed, but auth/session state stays private.

## Tier 1: templates, not live config

### Agent harnesses

Add redacted templates plus installer/doctor checks for:

- Pi: settings template, extension/package list, skill install expectations.
- Codex: config template, AGENTS conventions, no sessions/DBs/auth.
- Claude: settings/hooks template, no paste cache/session env/auth.
- OpenCode: path/tooling checks, no runtime service logs.
- ShitRat: CLI install/doctor and GitHub App status checks.
- JoelClaw: CLI install/doctor, gateway/status checks, no outbox.

### Secrets

Keep a named secret registry doc with purpose and env var mapping, but never values.

Useful names already migrated:

- `PI_LLM_API_KEY`
- `AGENT_AXIOM_TOKEN`
- `HUGE_ICONS_NPM_TOKEN`

Need candidates:

- AWS SSO/profile docs, not tokens.
- Vercel/Cloudflare/Linear project tokens only as `secrets` names.
- Customer/support/service tokens stay scoped by project namespace.

## Tier 2: nice-to-have polish

- `scripts/bootstrap-macos.sh` for Homebrew, fonts, casks, and macOS defaults.
- `scripts/bootstrap-repos.sh` reading a repo manifest.
- `scripts/bootstrap-dev-services.sh` for Redis/Postgres/OrbStack checks.
- `scripts/bootstrap-agent-templates.sh` for safe Pi/Codex/Claude template install.
- One `scripts/doctor.sh` that checks everything without leaking ignored files.
- A local-only `~/.zshrc.local.example` showing where private helpers live.

## Sharp rule

If the setup needs auth, the dotfiles repo should install the shape and run the doctor. The actual credential comes from `secrets`, first-party login, SSO, or a human-held private overlay. No exceptions. This is how we avoid turning a useful machine profile into a public key dumpster fire.
