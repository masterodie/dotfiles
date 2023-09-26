{ config, ... }:
{
  services.pipewire.enable = true;
  services.pipewire.audio.enable = true;
  sound.enable = false;
}
