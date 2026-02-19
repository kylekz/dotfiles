#!/bin/sh
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
NODE_VER=24.11.0

# detect OS
if grep -qi microsoft /proc/version 2>/dev/null; then
    OS="wsl"
elif [ "$(uname -s)" = "Darwin" ]; then
    OS="macos"
else
    OS="linux"
fi

# prompt for git name and email
echo "Git name:"
read -r gitname
echo "Git email:"
read -r gitemail

# symlink zshrc and starship config
ln -sf "$DOTFILES/.zshrc" ~/.zshrc
mkdir -p ~/.config
ln -sf "$DOTFILES/.config/starship.toml" ~/.config/starship.toml

# symlink terminal config based on OS
if [ "$OS" = "wsl" ]; then
    WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
    cp .config/.wezterm.lua "/mnt/c/Users/$WIN_USER/.wezterm.lua"
elif [ "$OS" = "macos" ]; then
    mkdir -p ~/.config/ghostty
    ln -sf "$DOTFILES/.config/ghostty" ~/.config/ghostty/config
fi

# change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
fi

# install tools
if [ "$OS" != "macos" ]; then
    sudo apt-get install -y build-essential procps curl file git zsh openssh-server
    echo "$USER ALL=(ALL) NOPASSWD: /usr/sbin/service ssh start" | sudo tee /etc/sudoers.d/ssh-start
fi
if ! command -v brew >/dev/null 2>&1; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
fi
if [ "$OS" = "macos" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
brew install fd fzf ripgrep ast-grep jq gh asdf postgresql@17 planetscale/tap/pscale tailscale starship

# setup git
mkdir -p ~/.config/git
sed -e "s/__GIT_NAME__/$gitname/" -e "s/__GIT_EMAIL__/$gitemail/" .config/git/gitconfig > ~/.config/git/config
ln -sf "$DOTFILES/.config/git/ignore" ~/.config/git/ignore

# setup node within asdf
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git 2>/dev/null || true
asdf install nodejs $NODE_VER
asdf set -u nodejs $NODE_VER

# setup corepack for pnpm
npm install --global corepack@latest
corepack enable
corepack install -g pnpm@latest
asdf reshim nodejs

# setup bun
curl -fsSL https://bun.sh/install | bash

# setup claude
curl -fsSL claude.ai/install.sh | bash
mkdir -p ~/.claude
ln -sf "$DOTFILES/.claude/CLAUDE.md" ~/.claude/CLAUDE.md
ln -sf "$DOTFILES/.claude/settings.json" ~/.claude/settings.json
ln -sf "$DOTFILES/.claude/statusline-command.sh" ~/.claude/statusline-command.sh
cp -r "$DOTFILES/.claude/agents" ~/.claude/
cp -r "$DOTFILES/.claude/commands" ~/.claude/

# start tailscale
sudo tailscale up