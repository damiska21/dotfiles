{
  description = "My NixOS configuration with zen-browser";

  inputs = {
    nixpkgs.url     = "nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zen-browser, ... }:
  let #let jsou definice variables uvnitř funkce startující s in
    system = "x86_64-linux";
    pkgs = import nixpkgs {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
    };
  };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
	modules = [

        # a) your existing configuration.nix (hardware, basic settings…)
        ./configuration.nix

        # b) A small inline module to turn on unfree + Steam + packages
        {
          # Turn on unfree packages for the entire system
          nixpkgs.config.allowUnfree = true;

          # Enable the NixOS Steam module
          programs.steam.enable   = true;

	  
          fonts.fontconfig.enable = true;

          # Install your system packages
          environment.systemPackages = with pkgs; [
            kitty zsh git unzip
            waybar rofi-wayland swww networkmanagerapplet
            brightnessctl pcmanfm syncthing
            bottles steam
            spotify discord beeper obsidian

            # zen-browser from the external flake:
            zen-browser.packages.${system}.twilight-official
          ];

          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
          ];

        }
      ];        
      }; #nixosSystem
  }; #in
}

