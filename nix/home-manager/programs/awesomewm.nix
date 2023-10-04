{ ... }:
{
  home = {
    file.xinitrc =
      {
        target = ".xinitrc";
        text = ''
          #!/bin/sh

          userresources=$HOME/.Xresources
          usermodmap=$HOME/.Xmodmap
          sysresources=/etc/X11/xinit/.Xresources
          sysmodmap=/etc/X11/xinit/.Xmodmap

          # merge in defaults and keymaps

          if [ -f $sysresources ]; then
              xrdb -merge $sysresources

          fi

          if [ -f $sysmodmap ]; then
              xmodmap $sysmodmap
          fi

          if [ -f "$userresources" ]; then
              xrdb -merge "$userresources"

          fi

          if [ -f "$usermodmap" ]; then
              xmodmap "$usermodmap"
          fi

          export QT_QPA_PLATFORMTHEME=qt5ct
          export LIBVA_DRIVER_NAME=nvidia
          export VDPAU_DRIVER=nvidia

          xrandr --output HDMI-0 --primary --left-of DVI-D-0
          darkman dark

          #feh --bg-scale /home/odie/Bilder/wallpaper/casey-horner-O0R5XZfKUGQ-unsplash.jpg

          lxpolkit &
          picom &
          nextcloud-client &
          udiskie &

          if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
          	eval $(dbus-launch --exit-with-session --sh-syntax)
          fi
          systemctl --user import-environment DISPLAY XAUTHORITY

          if command -v dbus-update-activation-environment >/dev/null 2>&1; then
            dbus-update-activation-environment DISPLAY XAUTHORITY
          fi

          exec awesome
        '';
        executable = true;
      };
    file.awesomewm = {
      target = ".config/awesome/rc.lua";
      source = ../../../config/awesomewm/.config/awesome/rc.lua;
      recursive = false;
    };
    file.awesomewm-custom = {
      target = ".config/awesome/local-settings.lua";
      source = ../../../config/awesomewm/.config/awesome/local-settings.lua;
      recursive = false;
    };
    file.awesomewm-themes = {
      target = ".config/awesome/themes";
      source = ../../../config/awesomewm/.config/awesome/themes;
      recursive = true;
    };
  };
}
