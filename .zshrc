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
  z  # Jump around directories
  macos  # macOS specific utils
  brew  # Homebrew completions
  docker  # Docker completions
  docker-compose
  npm  # npm completions
  zsh-autosuggestions  # Fish-like autosuggestions
  zsh-syntax-highlighting  # Fish-like syntax highlighting
  fzf  # Fuzzy finder
)

# Load custom plugins (install these first)
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

source $ZSH/oh-my-zsh.sh

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

# Enable better globbing
setopt EXTENDED_GLOB
setopt NULL_GLOB

# macOS specific settings
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# Better ls aliases
alias ls='ls -GF'
alias ll='ls -lhAGF'
alias la='ls -AGF'
alias l='ls -CF'

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

# Pure prompt
autoload -U promptinit; promptinit
prompt pure

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Editors
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export VISUAL="cursor"

# FZF configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --color=dark'

# FZF shell integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load local config if exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
