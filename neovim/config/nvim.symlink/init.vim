set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath


let globalLocalSettingsFile = "$HOME/.vimrc.local"
if filereadable(globalLocalSettingsFile)
    exec "source globalLocalSettingsFile"
endif

source ~/.vimrc
