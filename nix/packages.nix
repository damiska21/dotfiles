# packages.nix
{ pkgs, system, zen-browser ? null }:

with pkgs;

[
  #terminál
  kitty fastfetch zsh oh-my-posh
  #git a jeho auth
  git gh
  #desktop veci, top bar, otevirac programu, wallpaper, sit, kurzor, widgets
  waybar rofi-wayland swww networkmanagerapplet hyprcursor
  #config na audio a brightness monitoru
  pavucontrol brightnessctl
  #file manager a jeho dependencies
  pcmanfm gvfs glib
  #basic programy
  qimgv syncthing file-roller vlc
  #advanced programy
  bottles steam godot spotify discord beeper obsidian zed-editor
  #keyboard remapper
  kanata
  #minecraft
  prismlauncher jdk17
  #web browser
  zen-browser.packages.${system}.twilight-official
]
