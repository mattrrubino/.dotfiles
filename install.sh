#!/bin/bash
git clone --bare git@github.com:mattrrubino/.dotfiles.git $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout

# Handle checkout failure
if [ $? != 0 ]; then
  mkdir -p .config-backup
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
  config checkout
fi
