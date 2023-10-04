{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      roboto
      roboto-slab
      noto-fonts
      noto-fonts-emoji
      sarasa-gothic
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
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

  services.picom.enable = true;

  services.xserver = {
    enable = true;

    layout = "de";
    xkbVariant = "nodeadkeys";

    displayManager = {
      defaultSession = "none+awesome";
      startx.enable = true;
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
  };
}
