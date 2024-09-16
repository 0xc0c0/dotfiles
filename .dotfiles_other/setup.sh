#!/usr/bin/env bash

alias dotfiles="$(which git) --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"
TMP=$(mktemp -d)
if [[ -e ${HOME}/.dotfiles ]];then
    echo "saving ${HOME}/.dotfiles off as ${HOME}/.dotfiles.old"
    rm -rf ${HOME}/.dotfiles.old
    mv ${HOME}/.dotfiles ${HOME}/.dotfiles.old
fi
git clone --separate-git-dir=${HOME}/.dotfiles --recurse-submodules https://github.com/0xc0c0/dotfiles.git ${TMP}
[[ -z $(which rsync) ]] && sudo apt-get install -y rsync terminator
rsync --recursive --verbose --exclude '.git' ${TMP}/ ${HOME}/
rm -r ${TMP}
shopt -s expand_aliases
source ${HOME}/.aliases
dotfiles config --add status.showUntrackedFiles no
dotfiles ls-tree -r master --name-only ${HOME}
dotfiles status
