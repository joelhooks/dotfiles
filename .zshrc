# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""  # Disabled since we're using pure prompt

# Performance optimizations
zstyle ':omz:lib:directories' aliases no  # Disable directory aliases for speed
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
DISABLE_UNTRACKED_FILES_DIRTY="true"  # Faster git status in large repos
DISABLE_AUTO_UPDATE="true"  # Disable auto-update checks

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  macos  # macOS specific utils
  brew  # Homebrew completions
  docker  # Docker completions
  docker-compose
  npm  # npm completions
  zsh-autosuggestions  # Fish-like autosuggestions
  zsh-syntax-highlighting  # Fish-like syntax highlighting
  fzf  # Fuzzy finder
)
# NOTE: removed z plugin - using zoxide instead (faster, smarter)

# Load custom plugins (install these first)
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

source $ZSH/oh-my-zsh.sh

# Turbo completions - only recompile if older than 24h
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# zoxide - smarter cd (replaced z plugin)
eval "$(zoxide init zsh)"

# User configuration

# Homebrew paths (Apple Silicon compatible)
if [[ -d "/opt/homebrew" ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
  export HOMEBREW_PREFIX="/usr/local"
fi

# pnpm global binaries
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Language settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History optimization
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="$HOME/.zsh_history"
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY             # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file
setopt HIST_VERIFY               # Do not execute immediately upon history expansion

# Performance: Disable less common features
setopt NO_BEEP
setopt NO_FLOW_CONTROL
setopt NO_MAIL_WARNING
unsetopt BG_NICE

# Make Ctrl+S usable for apps/muxers (eg. Zellij scroll mode) by disabling XON/XOFF.
# macOS often has `ixon` enabled, which makes Ctrl+S "freeze" output instead of reaching apps.
if [[ -t 0 ]]; then
  stty -ixon
fi

# Enable better globbing
setopt EXTENDED_GLOB
setopt NULL_GLOB

# macOS specific settings
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# Modern ls with eza (install: brew install eza)
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --git --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias l='eza -1 --icons'
alias tree='eza --tree --icons -L 3 --git-ignore'

# bat > cat (install: brew install bat)
alias cat='bat --paging=never'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Catppuccin Macchiato"

# macOS specific aliases
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Git aliases (beyond what git plugin provides)
alias gst='git status -sb'
alias glog='git log --oneline --graph --decorate'
alias gdiff='git diff --color-words'
alias gclean='git clean -fd && git checkout -- .'
alias gnuke='git reset --hard && git clean -fd'

# Git worktrees - parallel branch heaven
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtl='git worktree list'
alias gwtr='git worktree remove'

# Development aliases
alias dev='cd ~/Code'
alias vim="nvim"
alias v="nvim"
alias c="cursor"
alias p="pnpm"
alias px="pnpm dlx"
alias pdev="pnpm dev"
alias pbuild="pnpm build"
alias ptest="pnpm test"

# Quick config editing
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'
alias nvimrc='$EDITOR ~/.config/nvim'
alias ghosttyrc='$EDITOR "$HOME/Library/Application Support/com.mitchellh.ghostty/config"'
alias zellijrc='$EDITOR ~/.config/zellij/config.kdl'

# Docker aliases
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dclean='docker system prune -af'
alias dstop='docker stop $(docker ps -aq)'
alias drm='docker rm $(docker ps -aq)'

# Quick navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# Zellij aliases
alias zj='zellij'
alias zja='zellij attach'
alias zjl='zellij list-sessions'
alias zjk='zellij kill-session'
alias zjka='zellij kill-all-sessions'
alias zjh='zellij --layout home'
alias zjo='zellij --layout opencode'
alias zm='zellij -l mobile -s phone'
alias zs='~/.config/zellij/zellij-sessionizer.sh'
bindkey -s '^f' 'zs\n'  # Ctrl+f to launch sessionizer

# Codex TUI in terminal multiplexers:
# Inline mode preserves scrollback in Zellij/tmux; alt-screen mode tends to eat it.
codex() {
  if [[ -n "${ZELLIJ:-}" || -n "${TMUX:-}" ]]; then
    command codex --no-alt-screen "$@"
  else
    command codex "$@"
  fi
}

# Useful functions
mkd() { mkdir -p "$@" && cd "$_"; }
tre() { tree -aC -I '.git|node_modules|.next|dist|build' --dirsfirst "$@" | less -FRNX; }
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Port management - life savers
whatport() { lsof -i ":$1" }
killport() { lsof -ti ":$1" | xargs kill -9 2>/dev/null && echo "killed port $1" || echo "nothing on port $1" }
ports() { lsof -iTCP -sTCP:LISTEN -n -P | tail -n +2 | awk '{print $9, $1}' | column -t }
ht() {
  echo "🎨 Catppuccin Macchiato themes:"
  echo "1. Mauve (purple)"
  echo "2. Blue"
  echo "3. Green"
  echo "4. Pink"
  echo -n "Select (1-4): "
  read choice
  case $choice in
    1) theme="catppuccin-macchiato-mauve" ;;
    2) theme="catppuccin-macchiato-blue" ;;
    3) theme="catppuccin-macchiato-green" ;;
    4) theme="catppuccin-macchiato-pink" ;;
    *) echo "❌ Invalid choice"; return 1 ;;
  esac
  sed -i '' "s/name = \".*\"/name = \"$theme\"/" ~/.config/atuin/config.toml
  echo "✅ Theme switched to $theme!"
  echo "🚀 Press Ctrl+R to see the new theme"
}

# Pure prompt
autoload -U promptinit; promptinit
prompt pure

# fnm - node version manager
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# atuin - enhanced shell history
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Atuin key bindings
bindkey '^r' atuin-search      # Ctrl+R for fuzzy history search
bindkey '^[[A' _atuin_search_widget  # Up arrow for context-aware history
bindkey '^[OA' _atuin_search_widget  # Up arrow (alternate)

# Atuin aliases
alias h='atuin search'          # Quick history search
alias hs='atuin stats'          # History statistics
alias hd='atuin history delete' # Delete history entry
# alias ht defined below as function
alias gt='~/Library/Application\ Support/com.mitchellh.ghostty/switch-theme.sh' # Switch Ghostty theme

# Editors
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export VISUAL="cursor"

# FZF configuration (install: brew install fzf fd)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --color=dark'

# FZF previews - makes all the difference
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --icons {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:wrap"

# FZF shell integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Public machine config

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"

# Secrets are leased on demand instead of exported into every shell.
_secret_lease() {
  command -v secrets >/dev/null 2>&1 || { echo "secrets CLI not found" >&2; return 127; }
  secrets lease "$1" --ttl "${2:-1h}" --client-id "zsh:${USER}@$(hostname -s)"
}

_secret_lease_required() {
  local value
  value="$(_secret_lease "$@")" || return
  [[ -n "$value" ]] || { echo "empty secret lease for $1" >&2; return 1; }
  printf '%s' "$value"
}

with-huge-icons-npm() {
  (( $# )) || { echo "usage: with-huge-icons-npm <command> [args...]" >&2; return 2; }
  local token
  token="$(_secret_lease_required HUGE_ICONS_NPM_TOKEN "${SECRETS_TTL:-1h}")" || return
  HUGE_ICONS_NPM_TOKEN="$token" "$@"
}

load-huge-icons-npm-token() {
  local token
  token="$(_secret_lease_required HUGE_ICONS_NPM_TOKEN "${1:-1h}")" || return
  export HUGE_ICONS_NPM_TOKEN="$token"
}

with-pi-llm() {
  (( $# )) || { echo "usage: with-pi-llm <command> [args...]" >&2; return 2; }
  local token
  token="$(_secret_lease_required PI_LLM_API_KEY "${SECRETS_TTL:-1h}")" || return
  PI_LLM_API_KEY="$token" \
    PI_LLM_MODEL="${PI_LLM_MODEL:-openai-codex/gpt-5.5}" \
    "$@"
}

load-pi-llm-secret() {
  local token
  token="$(_secret_lease_required PI_LLM_API_KEY "${1:-1h}")" || return
  export PI_LLM_API_KEY="$token"
  export PI_LLM_MODEL="${PI_LLM_MODEL:-openai-codex/gpt-5.5}"
}

with-agent-axiom() {
  (( $# )) || { echo "usage: with-agent-axiom <command> [args...]" >&2; return 2; }
  local token
  token="$(_secret_lease_required AGENT_AXIOM_TOKEN "${SECRETS_TTL:-1h}")" || return
  AGENT_AXIOM_TOKEN="$token" \
    AGENT_AXIOM_DATASET="${AGENT_AXIOM_DATASET:-egghead-rails}" \
    "$@"
}

load-agent-axiom-secret() {
  local token
  token="$(_secret_lease_required AGENT_AXIOM_TOKEN "${1:-1h}")" || return
  export AGENT_AXIOM_TOKEN="$token"
}

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun PATH is set once near the end of this file so Bun-owned CLIs win
# over fnm/npm/pnpm shims.

# Added by Ultimate Bug Scanner Installer
alias bash='/opt/homebrew/bin/bash'

export PI_LLM_MODEL="openai-codex/gpt-5.5"

# Swarm plugin pretty logging
export SWARM_LOG_PRETTY=1
export SWARM_DEBUG_MODE=1

# bun - canonical global JS CLI toolchain; Pi lives in ~/.bun/bin/pi.
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Private/local exports belong in ~/.zshrc.local (gitignored): tokens, customer app
# credentials, SAML material, and machine-specific one-offs stay out of public dotfiles.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
