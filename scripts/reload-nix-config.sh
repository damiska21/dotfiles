#!/usr/bin/env bash

#commit změny (ten argument bude v názvu commitu)
~/.dotfiles/scripts/commit.sh Nix-config

#aplikovat konfig
cd /etc/nixos
sudo cp /home/damiska/.dotfiles/nix/configuration.nix .
#sudo cp /home/damiska/.dotfiles/nix/flake.lock .
sudo cp /home/damiska/.dotfiles/nix/flake.nix .
sudo cp /home/damiska/.dotfiles/nix/packages.nix .

sudo nixos-rebuild switch --flake .#nixos
