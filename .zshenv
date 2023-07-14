export $(envsubst < ${HOME}/.env)

export EDITOR="vi"
[ -f /usr/bin/vim ] && export EDITOR="vim"
[ -f /usr/bin/nvim ] && export EDITOR="nvim"

export SUDO_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR

export BROWSER="firefox"

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

export PATH="$HOME/.local/bin:$PATH"

export DOTFILES_PATH="${XDG_DATA_HOME}/dotfiles"
[ -d ${DOTFILES_PATH} ] && export PATH="$DOTFILES_PATH/bin:$PATH"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
