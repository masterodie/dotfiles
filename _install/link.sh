#!/bin/bash

DOTFILES=$HOME/.dotfiles

echo "creating symlinks"
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    if [[ $file =~ "/config/" ]]
    then
        target="$HOME/.config/$( basename $file ".symlink" )"
    else
        target="$HOME/.$( basename $file ".symlink" )"
    fi
    if [ -L $target ]
    then
        echo "'$target' exists"
        ln -sff $file $target &> /dev/null
    else
        echo "creating symlink for '$file' at '$target'"
        ln -s $file $target &> /dev/null
    fi
done
