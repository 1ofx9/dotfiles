# Zinit - minimal initialization
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
[[ -f "${ZINIT_HOME}/zinit.zsh" ]] || git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Completion - optimized
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Plugins - deferred loading
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit light zsh-users/zsh-completions

zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# Keys and History
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

HISTSIZE=5000
SAVEHIST=5000
HISTFILE="$HOME/.zsh_history"
setopt sharehistory histignorespace

# Completion style
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:(z|zi|cd|zoxide):*' fzf-preview 'eza --color=always $realpath'

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Load PNPM (ensure pnpm is added to PATH)
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/soooobus/.zsh/completions:"* ]]; then export FPATH="/home/soooobus/.zsh/completions:$FPATH"; fi

. "/home/soooobus/.deno/env"

# bun completions
[ -s "/home/soooobus/.bun/_bun" ] && source "/home/soooobus/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Conditional tool loading
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
command -v starship >/dev/null && eval "$(starship init zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# Conda 
export PATH="/home/soooobus/miniconda3/bin:$PATH" 

# Aliases
alias ls='eza --icons --git'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias lsa='eza -a --icons --git'
alias lt='eza --tree --icons --git'
alias l='eza -1 --icons'
alias zz='zoxide query -i'
alias cd='z' 
alias ani='ani-cli'
alias ..='cd ..'
alias sudo='sudo '
alias rm='rm -v'
alias grep="grep --color=auto"

# zsh misc
edit-zsh() {
  local e=(
    "nvim"
    "code" 
    "gedit"
    "nano"
  )
  print "[1] Neovim (nvim)\n[2] VS Code (code)\n[3] gedit\n[4] nano"
  read -sk1 "c?Select: " && echo
  ${e[${c:-4}]:-nano} ~/.zshrc
}

reload-zsh() {
  local cfg=${ZDOTDIR:-~}/.zshrc t=${EPOCHREALTIME}
  [[ -f $cfg ]] || { echo >&2 "Missing: $cfg"; return 1 }
  source $cfg || { echo >&2 "Failed: $cfg"; return 2 }
  printf "Loaded: %s (%.2fs)\n" "$cfg" $((EPOCHREALTIME-t))
}
