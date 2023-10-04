{ pkgs, ... }:
{
  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = [
      pkgs.neovim-ide
    ];
  };
}
