#!/usr/bin/env bash

#získání času pro push message
now=$(date +"%Y-%m-%d %H:%M:%S")
msg="$1 změna: $now"

#pushnout na git
cd /home/damiska/.dotfiles
git add .
git commit -m "$msg"
#git push #pushovat si budu sám
