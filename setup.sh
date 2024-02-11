#!/bin/sh

NODE_VER=20.11.0

# prompt for git name and email
echo "Git name:"
read gitname
echo "Git email:"
read gitemail

# install zsh and jq (for nx-completions)
sudo apt install zsh jq -y

# setup git
git config --global user.email "$gitemail"
git config --global user.name "$gitname"

# install oh-my-zsh
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"

# install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

# copy zshrc
cp .zshrc ~/.zshrc

# run zsh
exec zsh

# install nx-completions
git clone git@github.com:jscutlery/nx-completion.git ~/.oh-my-zsh/custom/plugins/nx-completion

# install node/js tools
asdf plugin add nodejs
asdf install nodejs $NODE_VER
asdf global nodejs $NODE_VER
curl -fsSL https://get.pnpm.io/install.sh | sh -
pnpm i -g turbo
curl -fsSL https://bun.sh/install | bash