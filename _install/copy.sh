#!/bin/bash

DOTFILES=$HOME/.dotfiles

echo "copying files"
linkables=$( find -H "$DOTFILES" -maxdepth 4 -name '*.copy' )
for file in $linkables ; do
    target="$HOME/.$( basename $file ".copy" )"
    if [ -f $target ]
    then
        echo "'$target' exists"
    else
        echo "copying '$file' to '$target'"
        cp $file $target &> /dev/null
    fi
done
