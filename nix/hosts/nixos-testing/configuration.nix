{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos
    ../../nixos/bootloader/systemd-boot.nix
    ../../nixos/qemu-guest.nix
    ../../nixos/services/postgresql.nix
    ../../nixos/services/sound.nix
    ../../nixos/services/xserver.nix
    ../../nixos/programs/awesomewm.nix
  ];

  networking.hostName = "nixos-testing"; # Define your hostname.

  system.stateVersion = "23.05";
}

