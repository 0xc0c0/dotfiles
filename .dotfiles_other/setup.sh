#!/usr/bin/env bash

alias dotfiles="$(which git) --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
TMP=$(mktemp -d)
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/0xc0c0/dotfiles.git $TMP
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r $TMP
dotfiles config --local status.showUntrackedFiles no
dotfiles status