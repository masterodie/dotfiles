#!/usr/bin/env bash
#
/usr/bin/swayidle -w \
  timeout 300 "$HOME/.config/hypr/scripts/idle/actions/lock.sh" \
  timeout 600 "$HOME/.config/hypr/scripts/idle/actions/monitor_off.sh" \
  resume "$HOME/.config/hypr/scripts/idle/actions/monitor_on.sh" #\
  #before-sleep "$HOME/.config/hypr/scripts/idle/actions/lock.sh"
