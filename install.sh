#!/bin/bash

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

source _install/link.sh
source _install/copy.sh

if [[ ! $SHELL =~ 'zsh' ]]
then
    if [[ -f $(which zsh) ]]
    then
        echo "Configuring zsh as default shell"
        chsh -s $(which zsh)
    else
    fi
else
    echo "zsh is already the default shell"
fi

echo "Installing vim Plugins"
vim -c PlugUpgrade -c PlugInstall -c PlugUpdate -c quitall

echo "Done."
exit 0
