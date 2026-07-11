#!/usr/bin/env bash

./commit.sh Waybar

#rsync -av --delete --progress /home/damiska/.dotfiles/waybar/ /home/damiska/.config/waybar/
cp /home/damiska/.dotfiles/waybar/style.css /home/damiska/.config/waybar/

pkill waybar

waybar & disown waybar
