{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      alacritty
    ];
    file.alacritty = {
      target = ".config/alacritty";
      source = ../../../config/alacritty/.config/alacritty;
      recursive = true;
    };
  };
}
