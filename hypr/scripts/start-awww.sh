#!/usr/bin/env bash

awww-daemon --no-cache  || return $? &

wal -n -i "$HOME/Pictures/wallpaper" || return $?
sleep 2
awww img --transition-type center "$(< "${HOME}/.cache/wal/wal")" || return $?
/home/damiska/dotfiles/scripts/pywal-apply.sh
