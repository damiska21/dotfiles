#!/usr/bin/env bash
nm-applet &

#neotevře mi gui v browseru vždycky při startupu
syncthing --no-browser &

kanata -c /home/damiska/.config/kanata/main.kbd &

hyprlock & 

~/.config/hypr/scripts/start-awww.sh
