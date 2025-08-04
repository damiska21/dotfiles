{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable     = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Prague";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS         = "cs_CZ.UTF-8";
    LC_IDENTIFICATION  = "cs_CZ.UTF-8";
    LC_MEASUREMENT     = "cs_CZ.UTF-8";
    LC_MONETARY        = "cs_CZ.UTF-8";
    LC_NAME            = "cs_CZ.UTF-8";
    LC_NUMERIC         = "cs_CZ.UTF-8";
    LC_PAPER           = "cs_CZ.UTF-8";
    LC_TELEPHONE       = "cs_CZ.UTF-8";
    LC_TIME            = "cs_CZ.UTF-8";
  };

  #console.keyMap = "cz-lat2";

  #services.xserver.xkb = {
   # layout  = "cz";
  #  variant = "winkeys-qwerty";
 # };
  nixpkgs.config.allowUnfree = true;
  #až k useru je tohle nastaveni nvidia grafiky + zapnuti hyprlandu  
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
    nvidia.open = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  users.users.damiska = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description  = "damiska";
    extraGroups  = [ "networkmanager" "wheel" ];
  };

  programs.zsh.enable = true;
  
  #automatickej update všech packages
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  #automaticky maze nepouzivany packages starsi jak 10 dni
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;


  # Mount that extra filesystem
  fileSystems."/mnt/Bordel" = {
    device = "/dev/disk/by-uuid/3e2492b6-23cd-4f44-9fdf-0b7a74bac4f9";
    fsType  = "ext4";
    options = [ "rw" "user" "exec" "nofail" "x-systemd.after=network.target" ];
  };

  system.stateVersion = "25.05";
}
