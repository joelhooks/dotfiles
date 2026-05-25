#!/bin/bash

# Sync configs FROM system TO dotfiles repo
# This pulls any changes you've made locally back into the repo

set -e

echo "📥 Syncing configs from system to dotfiles repo..."
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to sync a file/directory
sync_config() {
    local source="$1"
    local dest="$2"
    local name="$3"
    
    if [ -e "$source" ]; then
        if [ -d "$source" ]; then
            rsync -av --delete "$source/" "$dest/"
        else
            cp "$source" "$dest"
        fi
        echo -e "${GREEN}  ✓ Synced $name${NC}"
    else
        echo -e "${YELLOW}  ⚠ Skipped $name (not found)${NC}"
    fi
}

sanitize_zshrc() {
    python3 - <<'PY'
from pathlib import Path

path = Path('.zshrc')
if not path.exists():
    raise SystemExit(0)

lines = path.read_text().splitlines()
out = []
skip_saml_block = False
skip_badass_stats_block = False
local_source = '[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local'

private_prefixes = (
    'export AGE_SECRET_KEY=',
    'export OP_SERVICE_ACCOUNT_TOKEN=',
    'export HUGE_ICONS_NPM_TOKEN=',
    'export PI_LLM_API_KEY=',
    'export AGENT_AXIOM_TOKEN=',
    'export AGENT_AXIOM_DATASET=',
    'export BEADS_AGENT_MAIL_URL=',
    'export JOELCLAW_CENTRAL_URL=',
    'alias ocw-',
    'alias log-beast=',
    'export OP_SERVICE_ACCOUNT_TOKEN=$(security find-generic-password -a "op-service-account-token" -s "skill-cli"',
    'export SKILL_AGE_KEY=',
    'claude() { command claude --dangerously-skip-permissions',
)

safe_private_export_lines = {
    'export HUGE_ICONS_NPM_TOKEN="$token"',
    'export PI_LLM_API_KEY="$token"',
    'export AGENT_AXIOM_TOKEN="$token"',
}

for line in lines:
    stripped = line.strip()

    if stripped == local_source:
        continue

    if stripped == '# >>> egghead-rails saml provider >>>':
        skip_saml_block = True
        continue
    if skip_saml_block:
        if stripped == '# <<< egghead-rails saml provider <<<':
            skip_saml_block = False
        continue

    if stripped.startswith('if [[ -z "${BADASS_STATS_AGE_PRIVATE_KEY:-}"'):
        skip_badass_stats_block = True
        continue
    if skip_badass_stats_block:
        if stripped == 'fi':
            skip_badass_stats_block = False
        continue

    if stripped.startswith(private_prefixes) and stripped not in safe_private_export_lines:
        continue

    if stripped in (
        '# age encryption key (stored in macOS Keychain)',
        '# Axiom observability (agent/infra use — not app-level)',
        '# skill-cli keychain integration',
        '# Added by Macroscope installer',
        '# Claude Code - skip permissions prompt',
        '# Beads Agent Mail - multi-agent coordination',
        '# BEADS_AGENT_NAME should be set per-agent (opencode, cursor, claude-web, etc.)',
        '# BEADS_PROJECT_ID auto-derives from directory name if not set',
        '# OpenCode Web service management',
        '# joelclaw memory capture central (Panda over Tailscale)',
        '# log-beast CLI for egghead-rails Axiom',
    ):
        continue

    if stripped == '# Load local config if exists':
        line = '# Public machine config'
    elif line == 'export PATH="$PATH:/Users/joel/go/bin"':
        line = 'export PATH="$PATH:$HOME/go/bin"'
    elif line == 'alias ghosttyrc=\'$EDITOR ~/.config/ghostty/config\'':
        line = 'alias ghosttyrc=\'$EDITOR "$HOME/Library/Application Support/com.mitchellh.ghostty/config"\''
    elif line == '[ -s "/Users/joel/.bun/_bun" ] && source "/Users/joel/.bun/_bun"':
        line = '[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"'
    elif line == 'export PATH=/Users/joel/.opencode/bin:$PATH':
        line = 'export PATH="$HOME/.opencode/bin:$PATH"'
    elif line == 'export PATH="/Users/joel/.local/bin:$PATH"':
        continue

    out.append(line)

compacted = []
for line in out:
    if line == '' and compacted and compacted[-1] == '':
        continue
    compacted.append(line)
out = compacted

while out and out[-1] == '':
    out.pop()

out.extend([
    '',
    '# Private/local exports belong in ~/.zshrc.local (gitignored): tokens, customer app',
    '# credentials, SAML material, and machine-specific one-offs stay out of public dotfiles.',
    local_source,
])

path.write_text('\n'.join(out) + '\n')
PY
    echo -e "${GREEN}  ✓ Sanitized zshrc for public dotfiles${NC}"
}

# Zsh
echo -e "${BLUE}Syncing Zsh...${NC}"
sync_config ~/.zshrc .zshrc "zshrc"
sanitize_zshrc

# Zellij
echo -e "${BLUE}Syncing Zellij...${NC}"
sync_config ~/.config/zellij/config.kdl zellij/config.kdl "config"
sync_config ~/.config/zellij/themes zellij/themes "themes"
sync_config ~/.config/zellij/layouts zellij/layouts "layouts"
sync_config ~/.config/zellij/cheats zellij/cheats "cheats"
sync_config ~/.config/zellij/zellij-sessionizer.sh zellij/zellij-sessionizer.sh "sessionizer"
sync_config ~/.config/zellij/README.md zellij/README.md "README"

# Atuin
echo -e "${BLUE}Syncing Atuin...${NC}"
sync_config ~/.config/atuin/config.toml atuin/config.toml "config"
sync_config ~/.config/atuin/themes atuin/themes "themes"
sync_config ~/.config/atuin/README.md atuin/README.md "README"

# Ghostty
echo -e "${BLUE}Syncing Ghostty...${NC}"
sync_config "$HOME/Library/Application Support/com.mitchellh.ghostty/config" ghostty/config "config"
sync_config "$HOME/Library/Application Support/com.mitchellh.ghostty/switch-theme.sh" ghostty/switch-theme.sh "theme switcher"
sync_config "$HOME/Library/Application Support/com.mitchellh.ghostty/README.md" ghostty/README.md "README"

# Karabiner
echo -e "${BLUE}Syncing Karabiner...${NC}"
sync_config ~/.config/karabiner.edn karabiner/karabiner.edn "config"
sync_config ~/.config/karabiner/README.md karabiner/README.md "README" 2>/dev/null || true

# Neovim (symlinked - no sync needed)
echo -e "${BLUE}Neovim...${NC}"
echo -e "${GREEN}  ✓ Symlinked (no sync needed)${NC}"

echo ""
echo -e "${GREEN}✨ Sync complete!${NC}"
echo ""
echo "Review changes with: git status"
echo "Commit changes with: git add -A && git commit -m 'Update configs from system'" 