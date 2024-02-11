export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="fino"
zstyle ':omz:update' mode auto
plugins=(git asdf docker docker-compose nx-completion)

source $ZSH/oh-my-zsh.sh

# pnpm
export PNPM_HOME="/home/kyle/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

alias explorer="explorer.exe ."
# bun completions
[ -s "/home/kyle/.bun/_bun" ] && source "/home/kyle/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Turso
export PATH="/home/kyle/.turso:$PATH"