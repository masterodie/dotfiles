{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      rofi
    ];
    file.rofi = {
      target = ".config/rofi";
      source = ../../../config/rofi/.config/rofi;
      recursive = true;
    };
    file.rofi-local = {
      target = ".local/share/rofi";
      source = ../../../config/rofi/.local/share/rofi;
      recursive = true;
    };
  };
}
