#!/bin/bash

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

source install/link.sh
source install/copy.sh

if [[ ! $SHELL =~ 'zsh' ]]
then
    echo "Configuring zsh as default shell"
    chsh -s $(which zsh)
else
    echo "zsh is already the default shell"
fi

echo "Done."
