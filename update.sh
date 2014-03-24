#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

#update git submodules
git submodule init
git submodule foreach git pull origin master
git submodule update

#Update VIM git submodules
cd vim
git submodule init
git submodule foreach git pull origin master
git submodule update
cd ..

#update symlinks
for i in *
do
        if [[ $i == $0 ]]
        then
                continue
        fi
       ln -sf $DIR/$i $HOME/.$i
done
ln -sf $DIR/vim/vimrc $HOME/.vimrc
