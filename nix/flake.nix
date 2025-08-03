{
  description = "My NixOS configuration with zen-browser";

  inputs = {
    nixpkgs.url     = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zen-browser, ... }:
  let #let jsou definice variables uvnitř funkce startující s in
    system = "x86_64-linux";
  in {
    nixosConfigurations."nixos" =
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          {
            #nixpkgs = {config.allowUnfree = true;};
            environment.systemPackages = with import nixpkgs {inherit system; config.allowUnfree = true;}; [
    kitty zsh git
    waybar rofi-wayland swww networkmanagerapplet brightnessctl
    pcmanfm vscodium
    syncthing 
    bottles
    steam
    spotify
    discord
    beeper
    obsidian
    zen-browser.packages."${system}".twilight-official
            ];
          }
        ];
      };
  };
}

