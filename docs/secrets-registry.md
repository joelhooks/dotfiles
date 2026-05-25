# Secrets Registry

Public registry of secret names this machine profile expects. Values live in `secrets`, never in Git.

## Current shell lease helpers

| Secret name | Env var | Helper | Purpose |
| --- | --- | --- | --- |
| `PI_LLM_API_KEY` | `PI_LLM_API_KEY` | `with-pi-llm`, `load-pi-llm-secret` | Temporary LLM API access for local tools that read `PI_LLM_*` env vars. |
| `AGENT_AXIOM_TOKEN` | `AGENT_AXIOM_TOKEN` | `with-agent-axiom`, `load-agent-axiom-secret` | Temporary Axiom access for agent/infra log tools. |
| `HUGE_ICONS_NPM_TOKEN` | `HUGE_ICONS_NPM_TOKEN` | `with-huge-icons-npm`, `load-huge-icons-npm-token` | Temporary npm/package access for Huge Icons. |

## Policy

- Lease only for the command that needs the secret when possible.
- Use `load-*-secret [ttl]` only for an interactive shell that genuinely needs exports.
- Do not put raw tokens in `.zshrc`, `.zshrc.local.example`, README, Brain notes, or scripts.
- Project tokens should be namespaced, for example `wzrrd::cloudflare_api_token` or `ai-hero::linear_api_key`.
- AWS uses SSO/profile login. Do not store AWS access keys in this repo.

## Useful checks

```bash
secrets status --no-update-check
secrets list --no-update-check
secrets audit --tail 20 --no-update-check
```
