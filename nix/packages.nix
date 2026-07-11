# packages.nix
{ pkgs, system, zen-browser ? null }:

with pkgs;

[
  #terminál
  kitty fastfetch zsh oh-my-posh lsd btop
  #git a jeho auth
  git gh
  #desktop veci: top bar, otevirac programu, wallpaper, sit, kurzor, color picker
  waybar rofi awww networkmanagerapplet hyprcursor hyprpicker
  #bluetooth
  bluez blueman
  #simple screenshot a screencapture
  grim slurp swappy wf-recorder
  #config na audio a brightness monitoru
  pulseaudio pipewire wireplumber pamixer pavucontrol brightnessctl
  #file manager a jeho dependencies
  nemo nemo-fileroller
  #basic programy
  qimgv syncthing file-roller vlc gparted qalculate-qt micro
  #advanced programy
  bottles spotify discord beeper anki twingate audacity keepassxc
  heroic protonup-qt protonplus mangohud reaper orca-slicer
  #x11 wm
  xinit xorgserver xauth
  #obsidian
  obsidian nodejs_22 # node na quartz
  #game dev / coding
  vscode libresprite android-studio code-cursor opencode 
  python315
  godotPackages_4_5.godot
  #keyboard remapper
  kanata
  #minecraft
  prismlauncher jdk17
  devenv direnv
  #hacking
  p7zip rpi-imager
  transmission_4 #torrent klient
  termius #ssh klient

docker
  ntfs3g
  #web browser
  zen-browser.packages.${system}.twilight-official
]
