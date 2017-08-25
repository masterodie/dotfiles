set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath


if filereadable($HOME . "/.vimrc.local")
    exec "source $HOME/.vimrc.local"
endif

source ~/.vimrc
