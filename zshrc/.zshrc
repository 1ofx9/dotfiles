# PATHS
export PATH=$PATH:$HOME/.local/bin
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# ZINIT SETUP
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ZINIT PLUGINS
zinit light zsh-users/zsh-completions

# Load selected Oh My Zsh snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::rust
zinit snippet OMZP::command-not-found

# Defer slow plugins
zinit light romkatv/zsh-defer
zsh-defer zinit light zsh-users/zsh-autosuggestions
zsh-defer zinit light zsh-users/zsh-syntax-highlighting
zsh-defer zinit light Aloxaf/fzf-tab

# COMPLETION CACHE
autoload -Uz compinit
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
compinit -d "$ZSH_COMPDUMP"

zinit cdreplay -q

# PROMPT (Oh My Posh)
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/omp-zen.toml)"

# ZSH OPTIONS
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# COMPLETION STYLES
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color=auto $realpath'

# TOOLS INIT
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# ALIASES
alias ls='ls --color'
alias ani='ani-cli'
alias reload-zsh='source ~/.zshrc'
alias edit-zsh='nvim ~/.zshrc'
alias cd='z'
alias sudo='sudo '

# PROFILE STARTUP TIMINGS
# Uncomment to test performance
# zsh_start_time=$(date +%s%N)
# zsh_end_time=$(date +%s%N)
# echo "ZSH startup time: $(( (zsh_end_time - zsh_start_time)/1000000 )) ms"

