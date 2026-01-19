#!/usr/bin/env bash
~/.config/hypr/scripts/start-swww.sh &

waybar &

nm-applet &

#neotevře mi gui v browseru vždycky při startupu
syncthing --no-browser &

kanata -c /home/damiska/.config/kanata/main.kbd &

hyprlock

