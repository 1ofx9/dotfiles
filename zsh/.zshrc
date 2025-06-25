# Aliases
alias ls='eza --icons --git'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias lsa='eza -a --icons --git'
alias lt='eza --tree --icons --git'
alias l='eza -1 --icons'
alias cd='z'
alias ..='cd ..'
alias zz='zoxide query -i'
alias ani='ani-cli'
alias rm='rm -v'
alias grep='grep --color=auto'
alias edit='msedit'
alias c='clear'
alias e='exit'

# Functions
zr() {
  [ -f ~/.zshrc ] && source ~/.zshrc && echo ".zshrc reloaded" || echo ".zshrc not found"
}

ze() {
  local e=("nvim" "nano" "code" "msedit")
  print "[1] Neovim\n[2] Nano\n[3] VS Code\n[4] ms-edit (default)"
  read -sk1 "c?Select: " && echo
  "${e[$(( ${c:-4} ))]}" ~/.zshrc
}

# starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#zoxide
eval "$(zoxide init zsh)"

# Bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
