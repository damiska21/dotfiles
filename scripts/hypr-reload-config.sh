#!/usr/bin/env bash

./commit.sh Hypr-config

#překopíruje všechny soubory v hypr/ tady do hypr/ v .config
rsync -av --delete --progress /home/damiska/.dotfiles/hypr/ /home/damiska/.config/hypr/

echo "Hyprctl reload: "

hyprctl reload
