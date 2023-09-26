{ config, pkgs, libs, ... }:
{
  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      gcc
      gnumake
      cmake
      nodejs
      rustc
      cargo
      go
      unzip
      pkgconfig
      glibc
      stdenv
      stdenv.cc
      stdenv.cc.cc
      stdenv.cc.libc
      stdenv.cc.libc_dev
    ];
    file.nvim = {
      target = ".config/nvim";
      source = ../../config/neovim/.config/nvim;
      recursive = true;
    };
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
