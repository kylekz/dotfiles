export PATH="$HOME/.bin:$PATH"

# WSL
alias explorer="explorer.exe ."

# asdf
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="fino"
zstyle ':omz:update' mode auto
plugins=(git asdf docker docker-compose)
source $ZSH/oh-my-zsh.sh

# bun 
[ -s "/home/kyle/.bun/_bun" ] && source "/home/kyle/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Turso
export PATH="/home/kyle/.turso:$PATH"

# Claude
alias claude="/home/kyle/.claude/local/claude"
