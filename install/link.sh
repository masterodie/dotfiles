#!/bin/bash

DOTFILES=$HOME/.dotfiles

echo "creating symlinks"
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target="$HOME/.$( basename $file ".symlink" )"
    if [ -L $target ]
    then
        echo "'$target' exists"
    else
        echo "creating symlink for '$file' at '$target'"
        ln -sf $file $target &> /dev/null
    fi
done
