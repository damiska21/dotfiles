#!/usr/bin/env bash

awww-daemon --no-cache &

WALLDIR="$HOME/Pictures/wallpaper"
FILE=$(find "$WALLDIR" -type f | shuf -n 1)

matugen image "$FILE"
