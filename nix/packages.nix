# packages.nix
{ pkgs, system, zen-browser ? null }:

with pkgs;

[
  #terminál
  kitty fastfetch zsh oh-my-posh
  #git a jeho auth
  git gh
  #desktop veci: top bar, otevirac programu, wallpaper, sit, kurzor
  waybar rofi-wayland swww networkmanagerapplet hyprcursor
  #bluetooth
  bluez blueman
  #simple screenshot a screencapture
  grim slurp swappy wf-recorder
  #config na audio a brightness monitoru
  pavucontrol brightnessctl
  #file manager a jeho dependencies
  pcmanfm gvfs glib
  #basic programy
  qimgv syncthing file-roller vlc
  #advanced programy
  bottles steam spotify discord beeper anki twingate
  #obsidian
  obsidian nodejs_22 # node na quartz
  #game dev / coding
  zed-editor godot libresprite
  #keyboard remapper
  kanata
  #minecraft
  prismlauncher jdk17
  #running avalonia apps (hollow knight mods)
  #libICE libSM libX11 libXcursor libXrandr libXrender libXi
  devenv
  #web browser
  zen-browser.packages.${system}.twilight-official
]
