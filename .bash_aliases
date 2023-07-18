#!/usr/bin/env bash

# File listing
alias ls='ls -F'
alias ll='ls -l'
alias la='ls -al'

# Colors
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='colordiff'

# Convinience
alias mkdir='mkdir -p'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Editor
alias vim='$EDITOR'
alias vi='vim'
alias e=vim

alias serve='python -m http.server'

# Network
alias ports='ss -tulpn'

# Shortcuts
alias cdv='cd ${XDG_CONFIG_HOME}/nvim'
alias cdd='cd ${XDG_DATA_HOME}/dotfiles'
alias eV='$EDITOR ~/.'
alias eZ='$EDITOR ~/.zshrc'
alias eZl='$EDITOR ~/.zshrc.local'

alias mpy='python manage.py'

alias artisan="php artisan"
