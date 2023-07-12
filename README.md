# Dotfiles

**Needs GNU stow**

## Installation

- Clone this repo to `${XDG_DATA_HOME}/dotfiles` (typically this is
`/home/<username>/.local/share/dotfiles`)
- Inside `${XDG_DATA_HOME}/dotfiles` execute `stow --target=$HOME .`

### Manual installation

- Clone this repository somewhere
- Inside the cloned repo execute `stow --target=$HOME .`

## Update

- Execute `dotfiles-sync`

### Manual update

- Navigate to the directory you installed this repo into and sync changes from
upstream
- Execute `stow --target=$HOME .`

## Uninstall

- Execute `dotfiles-clean` to remove all files
installed with stow

### Manual uninstallation

Navigate to the directory you installed this repo into
Inside the direcory `stow --target=$HOME --delete .`

