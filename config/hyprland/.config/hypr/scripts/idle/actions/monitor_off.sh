#!/usr/bin/env bash


idledir="$(dirname "$(dirname "$(realpath "$0")")")"

"$idledir/inhibitors/pulse.sh" || exit 1

hyprctl dispatch dpms off
