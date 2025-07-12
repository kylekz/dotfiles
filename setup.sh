#!/bin/sh

NODE_VER=22.17.0

# prompt for git name and email
echo "Git name:"
read gitname
echo "Git email:"
read gitemail

# install github cli, zsh, wget, curl
(type -p wget >/dev/null || (sudo apt update && sudo apt install zsh wget curl -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

# setup git
git config --global user.email "$gitemail"
git config --global user.name "$gitname"

# install oh-my-zsh
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"

# install asdf
mkdir -p ~/.asdf
wget https://github.com/asdf-vm/asdf/releases/download/v0.18.0/asdf-v0.18.0-linux-x86_64.tar.gz -O asdf.tar.gz
tar -xzf asdf.tar.gz -C ~/.asdf
rm asdf.tar.gz

# copy zshrc
cp .zshrc ~/.zshrc

# change default shell to zsh
chsh -s $(which zsh)

# source asdf for current session
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

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

# install claude
curl -fsSL claude.ai/install.sh | bash
cp -r .claude ~/