#!/usr/bin/env bash

sleep 1
cp /home/damiska/.cache/wal/pywal/micro.micro /home/damiska/.config/micro/colorschemes/pywal.micro

cp /home/damiska/.cache/wal/pywal/colors.conf /home/damiska/.config/hypr/colors.conf
echo "hyprctl reload:"
hyprctl reload

cp /home/damiska/.cache/wal/pywal/waybarconfig ~/.config/waybar/config
cp /home/damiska/.cache/wal/pywal/waybar.css ~/.config/waybar/theme.css
pkill waybar
waybar >/dev/null 2>&1 &

cp /home/damiska/.cache/wal/pywal/obsidcolors.css /home/damiska/Damian/.obsidian/snippets/colors.css

echo "aplikováno"
