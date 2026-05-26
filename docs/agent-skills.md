# Agent Skills Catalog

This repo tracks the portable shape of Joel's skill system: where skills live,
which sources are canonical, which consumers should get links, and what needs
repair before a fresh machine can be trusted.

It does not copy private runtime state, auth files, transcripts, caches, or raw
machine overlays. The catalog is receipts and install policy, not a dump.

## Operating Principle

Use upstream skills as source material, not as local truth.

Matt Pocock's skills are a strong fork basis, especially `handoff`, `triage`,
`diagnose`, `to-prd`, `to-issues`, `zoom-out`, and
`improve-codebase-architecture`. On Joel's machine, those workflows must be
adapted around `~/.brain`, pi-notes, prior agent sessions, dark-wizard/Panda
context, and Brain-first tracker mirroring. The install policy should prefer
Joel-owned adapted skills with the same trigger names over raw upstream links.

The fork-basis catalog is tracked in:

```bash
manifests/agent-skill-fork-basis.tsv
```

The active install manifest is:

```bash
manifests/agent-skill-install.tsv
```

## Current Receipts

Verified on this machine, 2026-05-25:

| Source | Count | Role | Notes |
| --- | ---: | --- | --- |
| `~/Code/joelhooks/joelclaw/skills` | 32 | owned source | Operational JoelClaw, gateway, Pi, memory, and system skills. Good pack, not the whole personal skill strategy. |
| `~/Code/badass-courses/skills` | 30 | owned source | Strategy, launch, Second Brain, Forte/PARA/JITPM, and course-building skills. Some depend on private corpora. |
| `~/Code/mattpocock/skills/skills` | 28 | upstream source | Engineering workflow skills. Local checkout was behind `origin/main`; fetched `origin/main` at `b8be62f` without merging. |
| `~/Code/skillrecordings/support/skills` | 55 | owned source | Support triage, incidents, customer voice, Effect, and Axiom skills. |
| `~/Code/joelhooks/dark-wizard/skills` | 15 | owned source | Private personal/operator skills, including Matt workflow forks customized for Brain/pi-notes/SVX/session-history workflows. |
| `~/Code/coreyhaines31/marketingskills/skills` | 40 | upstream source | Marketing, SEO, lifecycle, CRO, pricing, copy, and growth skills. |
| `~/Code/vercel-labs/agent-skills/skills` | 5 | upstream source | Vercel/react/web design/deploy skills. |
| `~/.codex/skills` | 67 resolved first-level skills | consumer | Mix of real skills, curated symlinks, selected dark-wizard skill links, and stale/broken legacy symlinks. |
| `~/.codex/plugins/cache` | 48 | consumer cache | Plugin-provided skills. Cache, not source of truth. |
| `~/.claude/skills` | 70 resolved first-level skills | consumer | Mix of real skills, curated symlinks, and stale/broken legacy symlinks. |
| `~/.agents/skills` | 13 resolved first-level skills | consumer | Real mixed directory currently holding only the selected dark-wizard Matt/SVX skill links. |
| `~/.pi/agent/skills` | 0 resolved first-level skills | consumer | Real machine-local Pi skill directory; joelclaw links removed on this machine. |
| `~/.config/opencode/skill` + `~/.config/opencode/skills` | 62 resolved first-level skills | consumer | Dark-wizard-style OpenCode config has generic/system skills plus Macroscope/ui. |

Run the live count any time:

```bash
./scripts/catalog-agent-skills.sh --summary
```

## Consumer State

Current consumer wiring is mixed but workable:

- `~/.agents/skills` is now a real mixed directory. The previous whole-directory symlink target was backed up, and the directory now holds only the selected dark-wizard Matt/SVX skill links; joelclaw consumer links were removed from this machine.
- `~/.pi/agent/skills` is a real machine-local directory; joelclaw links were removed from this machine.
- `~/.claude/skills` is a real mixed directory with many source-specific links, but many old links still break because they point through legacy paths.
- `~/.codex/skills` has real Codex skills, Badass symlinks, selected dark-wizard skill links, and stale legacy symlinks.
- `~/.config/opencode/skill` and `~/.config/opencode/skills` are real dirs and are safe bootstrap targets.

The bootstrap script still refuses to write through symlinked consumer roots. That rule stays: consumer roots should be real directories; individual skills should be symlinks to owning source repos.

Find broken links:

```bash
./scripts/catalog-agent-skills.sh --broken
```

## Applied Install Receipt

Ran on 2026-05-25:

```bash
./scripts/bootstrap-agent-skills.sh --apply --replace-links
```

Current result:

- Codex and `.agents` now point the requested Matt trigger names
  `write-a-skill`, `handoff`, `grill-me`, `caveman`, `triage`, `zoom-out`,
  `to-prd`, `to-issues`, `tdd`, `prototype`,
  `improve-codebase-architecture`, `grill-with-docs`, and `diagnose` at
  `~/Code/joelhooks/dark-wizard/skills/*`.
- The dark-wizard skill bodies keep upstream trigger descriptions mostly intact and put Brain/pi-notes/SVX behavior in the instructions instead of making descriptions weird.
- `.agents` was converted from a whole-directory joelclaw symlink to a real mixed directory during this pass. Backup receipt: `~/.skill-root-backups/20260525-220249-matt-svx-skills/`.
- JoelClaw consumer links were removed from `.agents`, `.codex`, `.claude`, OpenCode, and Pi skill roots because this machine should not advertise workflows that depend on unavailable JoelClaw runtime. Removal backups: `~/.skill-root-backups/20260525-220627-remove-joelclaw-consumer-links/` and `~/.skill-root-backups/20260525-220756-remove-pi-joelclaw-links/`.
- Remaining broken links are legacy/unmanaged skills, not the requested Matt/SVX install set. Audit them with `./scripts/catalog-agent-skills.sh --broken`.

## High-Leverage Personal Set

The repeatable install manifest is `manifests/agent-skill-install.tsv`. Tier 1
is the default "put this everywhere" layer across Claude, Codex, OpenCode, and
Pi once the consumer root can safely accept mixed symlinks.

Tier 1:

- Matt/JFS engineering loop from dark-wizard with Brain/pi-notes/SVX behavior in the skill body: `setup-matt-pocock-skills`, `diagnose`, `triage`, `to-prd`, `to-issues`, `zoom-out`, `improve-codebase-architecture`, `handoff`, `write-a-skill`, `tdd`, `prototype`, `grill-me`, `caveman`, `grill-with-docs`.
- Brain/project context from non-JoelClaw sources: `brain-first-workflow`, `second-brain-execution`, `how`.
- Operator memory/search from dark-wizard: `session-search` for Pi, Claude, and Codex session receipts via JoelClaw plus raw transcripts.

Tier 2 is powerful but more situational:

- Workflow pressure and craft: `good-questions`, `shipping-discipline`, `caveman`, `write-a-skill`.
- JoelClaw runtime skills are intentionally disabled on this machine until the runtime they depend on exists here.
- Support/incident: `skill-support`, `inbox-triage`, `effect-ts`,
  `axiom-investigation`.
- Dark-wizard operator work: `joels-inbox`.
- Vercel UI/React skills: `vercel-composition-patterns`,
  `vercel-react-best-practices`, `web-design-guidelines`,
  `vercel-react-native-skills`, `vercel-deploy-claimable`.

Tier 3 is a curated marketing layer, useful but noisy if always loaded:

- `customer-research`, `content-strategy`, `copywriting`, `seo-audit`,
  `programmatic-seo`, `product-marketing`.

Dry-run the curated links:

```bash
./scripts/bootstrap-agent-skills.sh
```

Apply safe links:

```bash
./scripts/bootstrap-agent-skills.sh --apply
```

Repair stale symlinks deliberately:

```bash
./scripts/bootstrap-agent-skills.sh --apply --replace-links
```

On this machine, `~/.agents/skills` and `~/.pi/agent/skills` are real directories. JoelClaw runtime-skill manifest rows are commented out so bootstrap does not re-add broken operational skills.

## Dark-Wizard, Panda, Brain, And Pi Notes

Dark-wizard has two relevant receipts:

- Local repo: `~/Code/joelhooks/dark-wizard`.
- Session-store snapshot: `~/Documents/dark-wizard-session-stores/20260523-082957/opencode/config`.

`~/.brain` resolves to `~/Code/joelhooks/dark-wizard/.brain`. That Brain is the
durable cross-project memory surface for machine/workflow decisions. pi-notes is
the agent-connected read/review surface for Brain; use `pi-notes brain check
[repo]` before relying on a repo's Brain layout.

The snapshot has OpenCode skills in both `skill/` and `skills/`, plus commands,
agents, tools, and knowledge docs. Those are configuration patterns worth
cataloging, not raw state to copy.

Prior agent sessions are part of the local evidence graph. Use bounded session
search before claiming "we already decided" or when dark-wizard/Panda/Pi history
matters:

```bash
joelclaw session search "<topic>" --source both --machine dark-wizard --runtime all --limit 5 --extract
```

The machine-wide `session-search` skill is canonical at
`~/Code/joelhooks/dark-wizard/skills/session-search/SKILL.md` and is installed
by symlink into `.agents`, Claude, Codex, Pi, and OpenCode skill roots.

Panda appears in current docs as the always-on M4 Pro Mac Mini / Central node
with Tailscale SSH, Inngest, Qdrant/Typesense, Redis, and gateway roles. I did
not find a local `panda` skill source directory. A prior system-review scan
mentions a missing `roam-research-panda` skill:

> Read-only access patterns for Joel's Roam Research archive repo on panda.

That skill is not present in the current `~/.pi/agent/skills`/`~/.agents/skills`
view. If Roam-on-Panda still matters, the next sensible move is to recreate or
recover `roam-research-panda` as a source-backed skill, probably under
`joelhooks/dark-wizard` or a dedicated `joelhooks/egghead-roam-research` skill
source, then add it to the install manifest.

## Repeatable Flow

For a fresh machine or repaired machine:

```bash
./scripts/bootstrap-repos.sh
./scripts/bootstrap-agent-tools.sh
./scripts/catalog-agent-skills.sh --markdown
./scripts/bootstrap-agent-skills.sh
```

Then keep consumer roots as real directories and install individual skill symlinks from the manifest. Do not use `~/.agents/skills -> joelclaw/skills` on this machine unless the JoelClaw runtime is actually present and intended to be the global pack.

Recommendation: make `joelhooks/dotfiles` the machine-level catalog and bootstrap authority, keep each skill source in its owning repo, and use symlinks as the install layer. Do not make `joelclaw/skills` the universal canonical root unless you actually want every personal skill to become JoelClaw system surface area.
