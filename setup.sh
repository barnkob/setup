#!/bin/bash
# Simple setup.sh for configuring Ubuntu 14 LTS for VirtualBox 
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y python-software-properties
wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh
# wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash


# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.13.1
nvm use v0.13.1

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
# sudo add-apt-repository -y ppa:cassou/emacs
# sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Install Midnight Commander
sudo apt-get install mc

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/barnkob/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sb dotfiles/.softhsm.conf
ln -sf dotfiles/.emacs.d .

# Set up Github
echo 'Please enter your git email: '
read GITMAIL
echo 'Please enter your git name: '
read GITNAME

git config --global user.email "$GITMAIL"
git config --global user.name "$GITNAME"

ssh-keygen -t rsa -C "$GITMAIL"
echo 'Copy the public key to github:'
echo ' '
cat ~/.ssh/id_rsa.pub

