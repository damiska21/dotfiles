#!/usr/bin/env bash

cd /etc/nixos
sudo cp /home/damiska/.dotfiles/configuration.nix .
sudo cp /home/damiska/.dotfiles/flake.lock .
sudo cp /home/damiska/.dotfiles/flake.nix .

sudo nixos-rebuild switch --flake .#nixos
