{ config, pkgs, lib, ... }:
{
  home = {
    file.awesomewm = {
      target = ".config/awesome";
      source = ../../config/awesomewm/.config/awesome;
      recursive = true;
    };
  };
}
