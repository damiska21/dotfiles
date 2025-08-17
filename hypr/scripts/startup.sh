#!/usr/bin/env bash

swww-daemon &

swww img /home/damiska/Pictures/wallpaper/1.jpg &

waybar &

nm-applet &

#neotevře mi gui v browseru vždycky při startupu
syncthing --no-browser
