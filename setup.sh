#!/bin/sh
set -e

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
read gitname
echo "Git email:"
read gitemail

# copy zshrc and starship config
cp .zshrc ~/.zshrc
mkdir -p ~/.config
cp .config/starship.toml ~/.config/starship.toml

# copy terminal config based on OS
if [ "$OS" = "wsl" ]; then
    WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
    cp .config/.wezterm.lua "/mnt/c/Users/$WIN_USER/.wezterm.lua"
elif [ "$OS" = "macos" ]; then
    mkdir -p ~/.config/ghostty
    cp .config/ghostty ~/.config/ghostty/config
fi

# change default shell to zsh
chsh -s $(which zsh)

# install tools
sudo apt-get install -y build-essential procps curl file git openssh-server
echo "$USER ALL=(ALL) NOPASSWD: /usr/sbin/service ssh start" | sudo tee /etc/sudoers.d/ssh-start
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install fd fzf ripgrep ast-grep jq gh asdf postgresql@17 planetscale/tap/pscale tailscale starship

# setup git
mkdir -p ~/.config/git
sed -e "s/__GIT_NAME__/$gitname/" -e "s/__GIT_EMAIL__/$gitemail/" .config/git/gitconfig > ~/.config/git/config
cp .config/git/ignore ~/.config/git/ignore

# setup node within asdf
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
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
cp -r .claude ~/

# start tailscale
sudo tailscale up