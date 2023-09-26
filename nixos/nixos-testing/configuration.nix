{ config, pkgs, modulesPath, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../_modules/efi.nix
    ../_modules/packages.nix
    ../_modules/users.nix
    ../_modules/ssh.nix
    ../_modules/system.nix
    ../_modules/pipewire.nix
    ../_modules/generic-qemu.nix
  ];

  networking.hostName = "nixos-testing"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    wget
    nix-index
    xorg.xinit
    cage
  ];

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      roboto
      roboto-slab
      noto-fonts
      noto-fonts-emoji
      sarasa-gothic
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly"]; })
    ];

    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        serif = [ "Roboto Slab" "Noto Serif" "Sarasa Gothic CL" "Symbols Nerd Font" ];
        sansSerif = [ "Roboto" "Noto Sans" "Sarasa Gothic CL" "Symbols Nerd Font" ];
        monospace = [ "JetBrains Mono" "Sarasa Mono CL" "Symbols Nerd Font Mono" ];
      };
    };
  };

  services.xserver = {
    enable = true;

    layout = "de";
    xkbVariant = "nodeadkeys";

    displayManager = {
      defaultSession = "none+awesome";
      sddm.enable = true;
    };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        accelProfile = "flat";
      };
    };

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
      ];
    };
  };


  system.stateVersion = "23.05";
}

