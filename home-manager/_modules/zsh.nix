{ config, pkgs, lib, ... }:
{
  home = {
    file = {
      ".zprofile".text = ''
        source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    lsd = {
      enable = true;
      enableAliases = true;
    };
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
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-completions"; }
          { name = "zdharma-continuum/fast-syntax-highlighting"; }
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "zsh-users/zsh-history-substring-search"; }
          { name = "chisui/zsh-nix-shell"; }
          { name = "nix-community/nix-zsh-completions"; }
        ];
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$os"
          "$username"
          "$hostname"
          "$directory"
          "$jobs"
          "$character"
        ];
        right_format = lib.concatStrings [
          "$aws"
          "$gcloud"
          "$openstack"
          "$azure"
          "$fossil_branch"
          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_metrics"
          "$git_statu"
          "$hg_branch"
          "$package"
          "$c"
          "$cmake"
          "$cobol"
          "$daml"
          "$dart"
          "$deno"
          "$dotnet"
          "$elixir"
          "$elm"
          "$erlang"
          "$fennel"
          "$golang"
          "$guix_shell"
          "$haskell"
          "$haxe"
          "$helm"
          "$java"
          "$julia"
          "$kotlin"
          "$gradle"
          "$lua"
          "$nim"
          "$nodejs"
          "$ocaml"
          "$opa"
          "$perl"
          "$php"
          "$pulumi"
          "$purescript"
          "$python"
          "$raku"
          "$rlang"
          "$red"
          "$ruby"
          "$rust"
          "$scala"
          "$solidity"
          "$swift"
          "$terraform"
          "$vlang"
          "$vagrant"
          "$zig"
          "$buf"
          "$nix_shell"
          "$conda"
          "$meson"
          "$spack"
          "$crystal"
        ];
        scan_timeout = 10;
        character = {
          success_symbol = "[](green)";
          error_symbol = "[](red)";
          format = " $symbol ";
        };

        username = {
          style_user = "green";
          style_root = "red";
          format = "[$user]($style)";
          disabled = false;
          show_always = true;
        };


        hostname = {
          ssh_only = false;
          format = "@[$hostname](cyan)";
          disabled = false;
          ssh_symbol = " ";
        };

        directory = {
          format = " [$path]($style)[$read_only]($read_only_style)";
          style = "yellow";
          truncation_length = 2;
          truncation_symbol = "…/";
          read_only = " 󰌾";
        };

        jobs = {
          format = " [$symbol$number]($style) ";
          symbol = "";
        };

        aws = {
          symbol = " ";
        };

        buf = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        c = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        conda = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        dart = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        docker_context = {
          symbol = " ";
        };

        elixir = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        elm = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        fossil_branch = {
          symbol = " ";
        };

        golang = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        guix_shell = {
          symbol = " ";
        };

        haskell = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        haxe = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        hg_branch = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        git_branch = {
          symbol = " ";
          format = "[$symbol$branch(:$remote_branch)]($style) ";
        };

        java = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        julia = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        lua = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        memory_usage = {
          symbol = "󰍛 ";
          format = "[$symbol($version )]($style)";
        };

        meson = {
          symbol = "󰔷 ";
          format = "[$symbol($version )]($style)";
        };

        nim = {
          symbol = "󰆥 ";
          format = "[$symbol($version )]($style)";
        };

        nix_shell = {
          symbol = " ";
          format = "[$symbol$state( \\($name\\))]($style)";
        };

        nodejs = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        os = {
          disabled = false;
          style = "blue";
        };

        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Windows = "󰍲 ";
        };

        package = {
          symbol = "󰏗 ";
          format = "[$symbol($version )]($style)";
        };

        pijul_channel = {
          symbol = " ";
        };

        python = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        rlang = {
          symbol = "󰟔 ";
          format = "[$symbol($version )]($style)";
        };

        ruby = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        rust = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };

        scala = {
          symbol = " ";
          format = "[$symbol($version )]($style)";
        };
      };
    };
  };
}
