{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alsa-utils
  ];
  services.pipewire.enable = true;
  services.pipewire.audio.enable = true;
  sound.enable = false;
}
