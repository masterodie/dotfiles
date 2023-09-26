{ config, pkgs, lib, ... }:
{
  imports = [
    ../_modules/zsh.nix
    ../_modules/git.nix
    ../_modules/neovim.nix
    ../_modules/lf.nix
    ../_modules/awesomewm.nix
    ../_modules/alacritty.nix
    ../_modules/tmux.nix
  ];

  home = {
    username = "odie";
    homeDirectory = "/home/odie";
    stateVersion = "23.05";
    packages = with pkgs; [
      fd
      ripgrep
      nix-index
      nixfmt
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}
