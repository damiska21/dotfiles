# packages.nix
{ pkgs, system, zen-browser ? null }:

with pkgs;

[
  #terminál
  kitty fastfetch zsh oh-my-posh
  #git a jeho auth
  git gh
  #desktop veci: top bar, otevirac programu, wallpaper, sit, kurzor
  waybar rofi swww networkmanagerapplet hyprcursor
  #bluetooth
  bluez blueman
  #simple screenshot a screencapture
  grim slurp swappy wf-recorder
  #config na audio a brightness monitoru
  pulseaudio pipewire wireplumber pamixer pavucontrol brightnessctl
  #file manager a jeho dependencies
  nemo nemo-fileroller
  #basic programy
  qimgv syncthing file-roller vlc gparted qalculate-qt
  #advanced programy
  bottles spotify discord beeper anki twingate audacity
  steam gamemode protonup-qt mangohud
  #obsidian
  obsidian nodejs_22 # node na quartz
  #game dev / coding
  vscodium libresprite android-studio code-cursor
  godotPackages_4_5.godot
  #keyboard remapper
  kanata
  #minecraft
  prismlauncher jdk17
  #running avalonia apps (hollow knight mods)
  #libICE libSM libX11 libXcursor libXrandr libXrender libXi
  devenv
  #hacking
  p7zip rpi-imager

docker
  ntfs3g
  #web browser
  zen-browser.packages.${system}.twilight-official
]
