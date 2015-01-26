#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo $DIR

#VIM files
declare -A VIM_FILES
VIM_FILES=( ['vim']='.vim' ['vim/vimrc']='.vimrc' )

#ZSH Files
declare -A ZSH_FILES
ZSH_FILES=( ['zshrc']='.zshrc' ['zshrc.linux']='.zshrc.local' ['zshrc.macos']='.zshrc.local' )

#OH MY ZSH
declare -A OH_MY_ZSH_FILES
OH_MY_ZSH_FILES=( ['oh-my-zsh']='.oh-my-zsh' ['zshrc.oh-my-zsh']='.zshrc.oh-my-zsh' )

#Update git submodules
function _update_git {
git submodule update --init --recursive
}

#Create symlink
function _create_zsh_symlinks {
for key in ${!ZSH_FILES[@]}
do
        ln -s "${DIR}/${key}" "${HOME}/${ZSH_FILES[${key}]}"
done
}

function _create_oh_my_zsh_symlinks {
for key in ${!OH_MY_ZSH_FILES[@]}
do
        ln -s ${DIR}/${key} ${HOME}/${OH_MY_ZSH_FILES[${key}]}
done
}

function _create_vim_symlinks {
for key in ${!VIM_FILES[@]}
do
        ln -s ${DIR}/${key} ${HOME}/${VIM_FILES[${key}]}
done
}

#remove symlinks
function _remove_zsh_symlinks {
for key in ${!ZSH_FILES[@]}
do
        unlink ${ZSH_FILES[${key}]}
done
}

function _remove_oh_my_zsh_symlinks {
for key in ${!OH_MY_ZSH_FILES[@]}
do
        unlink ${OH_MY_ZSH_FILES[${key}]}
done
}

function _remove_vim_symlinks {
for key in ${!VIM_FILES[@]}
do
        unlink ${VIM_FILES[${key}]}
done
}

#compile vim modules
function _compile_vim_youcompleteme {
if [ -e ~/.vim ]
then
        cd ~/.vim/bundle/youcompleteme/
        ./install.sh --clang-completer --system-libclang --system-boost
fi
}

function all {
        cd $DIR
        #_update_git
        _create_vim_symlinks
        _create_zsh_symlinks
        _create_oh_my_zsh_symlinks
        _compile_vim_youcompleteme
}

all
