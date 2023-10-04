{ config, ... }:
{
  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        j = "z";
        ji = "zi";
      };
      profileExtra = ''
        source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';
      initExtra = ''
                zstyle ':completion:*' menu select
                zstyle ':completion:complete:*' gain-privileges 1
        # disable sort when completing `git checkout`
                zstyle ':completion:*:git-checkout:*' sort false
        # set descriptions format to enable group support
                zstyle ':completion:*:descriptions' format '[%d]'
        # set list-colors to enable filename colorizing
                zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        # preview directory's content with exa when completing cd
              zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always --icon=always $realpath'
        # switch group using `,` and `.`
                zstyle ':fzf-tab:*' switch-group ',' '.'

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
                  compadd -S ''' "$(_gitignoreio_get_command_list)"
              }

              compdef _gitignoreio gi

      '';
      completionInit = ''
        autoload -U compinit bashcompinit
        compinit
        bashcompinit'';
      history = {
        path = "${config.xdg.dataHome}/zsh/zsh_history";
        save = 100000;
        size = 100000;
        share = true;
        extended = true;
      };
      historySubstringSearch = {
        enable = true;
      };
      antidote = {
        enable = true;
        plugins = [
          "zsh-users/zsh-completions"
          "zdharma-continuum/fast-syntax-highlighting"
          "zsh-users/zsh-autosuggestions"
          "zsh-users/zsh-history-substring-search"
          "chisui/zsh-nix-shell"
          "nix-community/nix-zsh-completions"
        ];
      };
    };
  };
}
