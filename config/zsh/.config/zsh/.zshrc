autoload -Uz compinit bashcompinit
compinit
bashcompinit

[[ -d "${ZDOTDIR}/.antidote" ]] || git clone --depth=1 "https://github.com/mattmc3/antidote.git" "${ZDOTDIR}/.antidote"

zsh_plugins="${ZDOTDIR}/.zsh_plugins.zsh"

# Ensure you have a .zsh_plugins.txt file where you can add plugins.
[[ -f "${zsh_plugins:r}.txt" ]] || touch "${zsh_plugins:r}.txt"

# Lazy-load antidote.
fpath+=("${ZDOTDIR}/.antidote")
autoload -Uz "${fpath[-1]}/antidote"

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
(antidote bundle <"${zsh_plugins:r}.txt" >|"$zsh_plugins")
fi

# Source your static plugins file.
# shellcheck source=.zsh_plugins.zsh
source "$zsh_plugins"

zstyle ':completion:*' menu select
zstyle ':completion:complete:*' gain-privileges 1

eval "$(zoxide init --cmd j zsh)"

source "/usr/share/fzf/key-bindings.zsh"
source "/usr/share/fzf/completion.zsh"

_fzf_compgen_path() {
fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
fd --type d --hidden --follow --exclude ".git" . "$1"
}


function gi() {
  curl -sLw '\n' "https://www.toptal.com/developers/gitignore/api/$*"
}

_gitignoreio_get_command_list() {
  curl -sL https://www.toptal.com/developers/gitignore/api/list | tr "," "\n"
}

_gitignoreio () {
  compset -P '*,'
  compadd -S '' "$(_gitignoreio_get_command_list)"
}

compdef _gitignoreio gi

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always --icon=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

[ -f "/usr/share/fzf/fzf-extras.zsh" ] && source /usr/share/fzf/fzf-extras.zsh
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

export HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY

eval "$(starship init zsh)"

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
