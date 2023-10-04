{  pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      lf
      ctpv
    ];
    file.lf = {
      target = ".config/lf";
      source = ../../../config/lf/.config/lf;
      recursive = true;
    };
  };
}
