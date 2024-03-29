#
# ~/.bashrc
#

export $(envsubst < ${HOME}/.env)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Normal Colors
Black="\[$(tput setaf 0)\]"        # Black
Red="\[$(tput setaf 1)\]"          # Red
Green="\[$(tput setaf 2)\]"        # Green
Yellow="\[$(tput setaf 3)\]"       # Yellow
Blue="\[$(tput setaf 4)\]"         # Blue
Purple="\[$(tput setaf 5)\]"       # Purple
Cyan="\[$(tput setaf 6)\]"         # Cyan
White="\[$(tput setaf 7)\]"        # White

# Bold
Bold="\[$(tput bold)\]"       # Black
Bold="\[$(tput dim)\]"       # Dim
Bold="\[$(tput smso)\]"       # Standout
Bold="\[$(tput invis)\]"       # Invisible
Reset="\[$(tput sgr0)\]"       # Invisible

# Background
On_Black="\[$(tput setab 0)\]"        # Black
On_Red="\[$(tput setab 1)\]"          # Red
On_Green="\[$(tput setab 2)\]"        # Green
On_Yellow="\[$(tput setab 3)\]"       # Yellow
On_Blue="\[$(tput setab 4)\]"         # Blue
On_Purple="\[$(tput setab 5)\]"       # Purple
On_Cyan="\[$(tput setab 6)\]"         # Cyan
On_White="\[$(tput setab 7)\]"        # White

NC=$Reset               # Color Reset

function prompt_username {
    # Test user type:
    if [[ "${USER}" == "root" ]]; then
        DEFAULT_USER="unknown"
        SU=${Red}           # User is root.
    elif [[ "$[UID]" == "0" ]]; then
        DEFAULT_USER="unknown"
        SU=${Red}           # User is root.
    elif [[ ${USER} != $(whoami) ]]; then
        SU=${BRed}          # User is not login user.
    else
        SU=${Green}         # User is normal (well ... most of us are).
    fi
    [[ "$DEFAULT_USER" == "$USER" ]] || echo -n "${SU}\u${NC}::"
}

function prompt_hostname {
    [[ -n "$SSH_CONNECTION" ]] && echo -n "${Cyan}\h${NC}::"
}

function prompt_directory {
    echo -n "${Yellow}\W${NC}"
}

function prompt_end {
    retval=$Green
    [[ $? == 0 ]] || retval=$Red
    symbol="▸"
    end="${retval} ${symbol}${NC} "
    echo -n "${end}"
}

# PS1='[\u@\h \W]\$ '
PS1="$(prompt_username)$(prompt_hostname)$(prompt_directory)$(prompt_end)"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
