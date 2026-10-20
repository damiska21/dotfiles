#!/usr/bin/env bash

cp -r /home/damiska/dotfiles/pywal /home/damiska/.config/wal/templates

wal -n -i "/home/damiska/Pictures/wallpaper/frieren.jpeg"
awww img --transition-type center "$(< "${HOME}/.cache/wal/wal")"

~/dotfiles/scripts/pywal-apply.sh
