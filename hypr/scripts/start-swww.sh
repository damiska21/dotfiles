#!/usr/bin/env bash

swww-daemon &

WALLDIR="$HOME/Pictures/wallpaper"
FILE=$(find "$WALLDIR" -type f | shuf -n 1)

swww img "$FILE" --transition-type any --transition-step 40
