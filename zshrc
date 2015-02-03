###Get local machine settings
[ -e ~/.zshrc.system ]  && source ~/.zshrc.system

###Get local machine settings
[ -e ~/.zshrc.local ]  && source ~/.zshrc.local

if (set -u; : $DEFAULT_USER) then
        export DEFAULT_USER=$USER
fi

if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi

##### Avoid beeing
setopt nobeep

##### History options
setopt APPEND_HISTORY
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

#for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt always_to_end

###Make GNUStep Happy
set -y

#####Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

##### Variables
BROWSER="firefox"

##### Keybindings
#bindkey -e
autoload up-line-or-beginning-search \
down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "\e[5~" up-line-or-beginning-search
bindkey "\e[6~" down-line-or-beginning-search
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del


command -v fortune >/dev/null 2>&1 || fortune 25% tbbt 25% starwars 25% futurama 25% chalkboard

##### OH MY ZSH

#Get zsh settins
[ -e ~/.zshrc.oh-my-zsh ] && source ~/.zshrc.oh-my-zsh && source ~/.oh-my-zsh/oh-my-zsh.sh



