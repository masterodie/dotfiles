ZDOTDIR=${ZDOTDIR:-$HOME}
ANTIDOTE_DIR="${ZDOTDIR}/.antidote"
[[ ! -d "${ANTIDOTE_DIR}" ]] && git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR}/.antidote

# Set the name of the static .zsh plugins file antidote will generate.
zsh_plugins=${ZDOTDIR}/.zsh_plugins.zsh

# Ensure you have a .zsh_plugins.txt file where you can add plugins.
[[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt

fpath+=(${ZDOTDIR}/.antidote)
autoload -Uz compinit bashcompinit $fpath[-1]/antidote
compinit
bashcompinit

zstyle ':completion:*' menu select
zstyle ':completion:complete:*' gain-privileges 1


# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
  (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
