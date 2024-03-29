{ pkgs,... }:
{
  home = {
    packages = with pkgs; [
      direnv
      nix-direnv
    ];
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
