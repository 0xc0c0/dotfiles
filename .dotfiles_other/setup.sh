#!/usr/bin/env bash

alias dotfiles="$(which git) --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
TMP=$(mktemp -d)
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/0xc0c0/dotfiles.git $TMP
[[ -z $(which rsync) ]] && sudo apt-get install rsync -y
rsync --recursive --verbose --exclude '.git' $TMP/ $HOME/
rm -r $TMP
dotfiles config --add status.showUntrackedFiles no
dotfiles ls-tree -r master --name-only $HOME
dotfiles status
