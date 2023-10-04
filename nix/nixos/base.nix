{ pkgs, ... }:
{
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";

  console = {
    keyMap = "de-latin1-nodeadkeys";
  };

  environment = {
    shells = with pkgs; [
      zsh
    ];
    systemPackages = with pkgs; [
      wget
      curl
      btop
    ];
  };

  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.auto-optimise-store = true;
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports = [
    ./programs
    ./services
  ];
}
