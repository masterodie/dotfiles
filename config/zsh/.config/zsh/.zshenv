set -o allexport
source "${HOME}/.env"
set +o allexport

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ANTIDOTE_DIR="${ZDOTDIR}/.antidote"
[[ ! -d "${ANTIDOTE_DIR}" ]] && git clone https://github.com/mattmc3/antidote.git "${ZDOTDIR}/.antidote"

