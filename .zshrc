# start SSH server if not running
if ! pgrep -x "sshd" > /dev/null; then
    sudo service ssh start > /dev/null 2>&1
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export COLORTERM=truecolor
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
export PATH="$HOME/.bin:$PATH"

# WSL
alias explorer="explorer.exe ."

# asdf
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# homebrew
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

# starship prompt
eval "$(starship init zsh)"

# fix wezterm pane splitting dir
__wezterm_osc7() {
  printf '\033]7;file://localhost%s\007' "$PWD"
}
chpwd_functions+=(__wezterm_osc7)
precmd_functions+=(__wezterm_osc7)

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
