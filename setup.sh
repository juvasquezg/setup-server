#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
sudo apt-get install -y curl
curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.26
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24 and vim
# https://launchpad.net/~cassou/+archive/emacs
sudo apt-get install python-software-properties
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg
sudo apt-get install vim-nox

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# Install openssh-server
sudo apt-get install openssh-server

# Install build-essential
sudo apt-get install build-essential libssl-dev

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
cd $HOME/clones
git clone https://github.com/juvasquezg/dotfiles.git
ln -sb clones/dotfiles/.screenrc $HOME
ln -sb clones/dotfiles/.bash_profile $HOME
ln -sb clones/dotfiles/.bashrc $HOME
ln -sb clones/dotfiles/.bashrc_custom $HOME
ln -sf clones/dotfiles/.emacs.d $HOME
ln -sf clones/dotfiles/.bash_aliases $HOME

git clone --recursive https://github.com/capitaomorte/yasnippet $HOME/clones/dotfiles/.emacs.d/plugins/yasnippet
