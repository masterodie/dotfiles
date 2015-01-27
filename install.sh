#!/usr/bin/env bash

KERNEL=`uname -s`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#VIM files
declare -A VIM_FILES
VIM_FILES=( ['vim']='.vim' ['vim/vimrc']='.vimrc' )

#Misc files
declare -A MISC_FILES
MISC_FILES=( ['tmux.conf']='.tmux.conf' )

#ZSH Files
declare -A ZSH_FILES
ZSH_FILES=( ['zshrc']='.zshrc' ['zshrc.local']='.zshrc.local' ['zshenv']='.zshenv' )
ZSH_SYSTEM_FILE=
case "$KERNEL" in
        "Linux")
                ZSH_SYSTEM_FILE="zshrc.linux"
                ;;
        "Darwin")
                ZSH_SYSTEM_FILE="zshrc.macos"
                ;;
esac

#OH MY ZSH
declare -A OH_MY_ZSH_FILES
OH_MY_ZSH_FILES=( ['oh-my-zsh']='.oh-my-zsh' ['zshrc.oh-my-zsh']='.zshrc.oh-my-zsh' )

#Update git submodules
function _update_git_base {
git submodule update --init
}

function _update_git_vim {
_update_git_base
cd $DIR/vim; git submodule update --init --recursive
}

#Create symlink
function _create_zsh_symlinks {
for key in ${!ZSH_FILES[@]}
do
        ln -s ${DIR}/${key} ${HOME}/${ZSH_FILES[${key}]}
done
ln -s ${DIR}/${ZSH_SYSTEM_FILE} ${HOME}/.zshrc.system
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

function _create_misc_symlinks {
for key in ${!MISC_FILES[@]}
do
        ln -s ${DIR}/${key} ${HOME}/${MISC_FILES[${key}]}
done
}

#remove symlinks
function _remove_zsh_symlinks {
for key in ${!ZSH_FILES[@]}
do
        unlink ${HOME}/${ZSH_FILES[${key}]}
done
unlink ${HOME}/.zshrc.system
}

function _remove_oh_my_zsh_symlinks {
for key in ${!OH_MY_ZSH_FILES[@]}
do
        unlink ${HOME}/${OH_MY_ZSH_FILES[${key}]}
done
}

function _remove_vim_symlinks {
for key in ${!VIM_FILES[@]}
do
        unlink ${HOME}/${VIM_FILES[${key}]}
done
}

function _remove_misc_symlinks {
for key in ${!MISC_FILES[@]}
do
        unlink ${HOME}/${MISC_FILES[${key}]}
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

function _install_vim {
        cd $DIR
        _create_vim_symlinks
        _compile_vim_youcompleteme
}

function _install_zsh {
        cd $DIR
        _update_git_base
        _create_zsh_symlinks
}

function _install_oh_my_zsh {
        cd $DIR
        _create_oh_my_zsh_symlinks
}

function _install_misc {
        cd $DIR
        _create_misc_symlinks
}

case "$1" in
        all)
                _update_git_vim
                _install_vim
                _install_zsh
                _install_oh_my_zsh
                ;;
        vim)
                _update_git_base
                _install_vim
                ;;
        misc)
                _update_git_base
                _install_misc
                ;;
        zsh)
                _update_git_base
                _install_zsh
                ;;
        oh-my-zsh)
                _update_git_base
                _install_zsh
                _install_oh_my_zsh
                ;;
        unlink)
                _remove_vim_symlinks
                _remove_oh_my_zsh_symlinks
                _remove_zsh_symlinks
                _remove_misc_symlinks
                ;;
        relink)
                _remove_vim_symlinks
                _remove_oh_my_zsh_symlinks
                _remove_zsh_symlinks
                _remove_misc_symlinks

                _create_vim_symlinks
                _create_oh_my_zsh_symlinks
                _create_zsh_symlinks
                _create_misc_symlinks
                ;;
        *)
                echo "Usage: ${0} {all|vim|zsh|oh-my-zsh|misc|unlink|relink}"
esac
