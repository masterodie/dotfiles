{ config, pkgs, lib, ... }:
{
  home = {
    packages = with pkgs; [
      tmux
    ];
    file.tmux = {
      target = ".tmux.conf";
      source = ../../config/tmux/.tmux.conf;
    };
  };
}
