{ config, pkgs, ... }:
{
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1-nodeadkeys";
  };

  environment = {
    shells = with pkgs; [
      zsh
    ];
    systemPackages = with pkgs; [
      wget
      curl
    ];
  };

  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
