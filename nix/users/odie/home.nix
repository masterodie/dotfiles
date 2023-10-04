{ pkgs, ... }:
{
  imports = [
    ../../home-manager/programs/zsh.nix
    ../../home-manager/programs/git.nix
    ../../home-manager/programs/neovim.nix
    ../../home-manager/programs/lf.nix
    ../../home-manager/programs/awesomewm.nix
    ../../home-manager/programs/alacritty.nix
    ../../home-manager/programs/tmux.nix
    ../../home-manager/programs/rofi.nix
    ../../home-manager/programs/firefox.nix
    ../../home-manager/programs/direnv.nix
    ../../home-manager/programs/fzf.nix
    ../../home-manager/programs/lsd.nix
    ../../home-manager/programs/starship.nix
    ../../home-manager/programs/zoxide.nix
    ../../home-manager/services/syncthing.nix
  ];

  home = {
    username = "odie";
    homeDirectory = "/home/odie";
    stateVersion = "23.05";
    packages = with pkgs; [
      fd
      ripgrep
      nix-index
      direnv
      nix-direnv
      lazygit
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}
