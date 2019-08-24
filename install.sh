#!/usr/bin/env bash

DIR=$(pwd)

echo "Installing dotfiles"
git pull

echo "Initializing submodule(s)"
git submodule update --init --recursive

mkdir $HOME/.config
source _install/link.sh
source _install/copy.sh

if [[ ! $SHELL =~ 'zsh' ]]
then
    if [[ -f $(which zsh) ]]
    then
        echo "Configuring zsh as default shell"
        chsh -s $(which zsh)
    else
        echo "zsh not found using default"
    fi
else
    echo "zsh is already the default shell"
fi

echo "Installing FZF"
bash ${PWD}/fzf/install --key-bindings --completion --no-update-rc --no-fish

echo "Installing vim Plugins"
vim -c PlugUpgrade -c PlugInstall -c PlugUpdate -c quitall


echo "Done."
exit 0
