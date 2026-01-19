{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "damiska" ];

  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.loader.systemd-boot.enable     = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "damiska" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

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


  #bluetooth
  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        experimental = true; # show battery
        # https://www.reddit.com/r/NixOS/comments/1ch5d2p/comment/lkbabax/
        Privacy = "device";
        JustWorksRepairing = "always";
        Class = "0x000100";
        FastConnectable = true;
      };
    };
  services.blueman.enable = true;
  hardware.xpadneo.enable = true;
  boot = {
      extraModulePackages = with config.boot.kernelPackages; [ xpadneo rtw88];#rtw je kernel na ac600
      extraModprobeConfig = ''
        options bluetooth disable_ertm=Y
      '';
      # connect xbox controller
    };
    services.pipewire = {
  enable = true;
  pulse.enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  wireplumber.enable = true;
  wireplumber.extraConfig = {
    "00-bluetooth-policy" = {
      "bluez-monitor.rules" = [
        {
          matches = [{ "device.name" = "~bluez_card.*"; }];
          actions.update-props = {
            "bluez5.reconnect-profiles" = [ "a2dp-sink" ];
            "bluez5.profiles" = [ "a2dp-sink" ];
          };
        }
      ];
    };
  };
};

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

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
    nvidia.open = false;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:5:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.graphics.extraPackages = with pkgs; [
    mesa
    vulkan-loader
    vulkan-validation-layers
    mangohud
  ];

  programs.hyprlock.enable = true;
  programs.adb.enable = true; # kvůli android devu

  users.users.damiska = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description  = "damiska";
    extraGroups  = [ "networkmanager" "wheel" "input" "kvm" "adbusers" "dialout" "plugdev" "docker" "wireshark"];
  };

  #networking.firewall.allowedTCPPorts = [ 8081 ];#expo go
virtualisation.docker.enable = true;
hardware.nvidia-container-toolkit.enable = true;

  programs.zsh.enable = true;

  services.twingate.enable = true;
#kanata (keyboard remapper) nastavení na fungování přes hypr
  services.kanata.enable = true;
  boot.kernelModules = [ "uinput" "rtw88" ];#rtw je na ac600

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
    SUBSYSTEM=="usb", ATTR{idVendor}=="2ec2", ATTR{idProduct}=="0003", MODE="0666", GROUP="users"
    SUBSYSTEM=="tty", ATTRS{idVendor}=="2ec2", ATTRS{idProduct}=="0003", MODE="0666", GROUP="dialout"
  '';

  systemd.user.services.kanata = {
    description = "Kanata keyboard remapper";
    after = [ "graphical-session.target" ];
    wantedBy = [ "default.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.kanata}/bin/kanata -c /home/damiska/.config/kanata/config.yaml";
      Restart = "always";

      # jen priority věci, co systemd user dovolí
      IOSchedulingClass = "realtime";
      Nice = -10;
    };
  };

  services.gvfs.enable = true;
  programs.fuse.userAllowOther = true;

  services.getty.autologinUser = "damiska";
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

  system.stateVersion = "25.11";

  # hacking
  programs.wireshark.enable = true;
  programs.wireshark.usbmon.enable = true;
  networking.firewall.interfaces."eno1".allowedTCPPorts = [ 4444 ];
  networking.networkmanager.unmanaged = [
  "interface-name:enp5s0f4u2"
];
}
