#!/bin/sh
set -e

NODE_VER=24.11.0

# prompt for git name and email
echo "Git name:"
read gitname
echo "Git email:"
read gitemail

# copy zshrc and starship config
cp .zshrc ~/.zshrc
mkdir -p ~/.config
cp .config/starship.toml ~/.config/starship.toml

# change default shell to zsh
chsh -s $(which zsh)

# install tools
sudo apt-get install -y build-essential procps curl file git openssh-server
echo "$USER ALL=(ALL) NOPASSWD: /usr/sbin/service ssh start" | sudo tee /etc/sudoers.d/ssh-start
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install fd fzf ripgrep ast-grep jq gh asdf postgresql@17 planetscale/tap/pscale tailscale starship

# setup git
git config --global user.email "$gitemail"
git config --global user.name "$gitname"

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