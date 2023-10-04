{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      syncthing
    ];
  };

  services = {
    syncthing = {
      enable = true;
      extraOptions = [
        "--gui-address=0.0.0.0:8384"
      ];
    };
  };
}
