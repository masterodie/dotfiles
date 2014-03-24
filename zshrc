##### OH MY ZSH
export DEFAULT_USER="odie"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="odie"
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(zsh-syntax-highlighting git)

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
alias pacman='sudo pacman-color'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias archey='LC_ALL=en_US.UTF8 archey'
alias chromium="run-or-raise chromium chromium"
alias emacs='emacsclient -c -a ""'
alias newncmpc="urxvt -e ncmpc"
alias trende="google-translate en de"
alias scrot="scrot -e 'mv \$f ~/screenshots/'"
alias gvim="gvim --remote-silent"
alias ctags=/usr/local/bin/ctags

#Disable zsh autocorrection for common commands
alias vim="nocorrect vim"
alias urxvt="nocorrect urxvtc"

##### Variables
BROWSER="firefox"

##### Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

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


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

command -v fortune >/dev/null 2>&1 || fortune 25% tbbt 25% starwars 25% futurama 25% chalkboard
