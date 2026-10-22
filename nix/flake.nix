{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    matugen.url = "github:InioX/Matugen";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zen-browser, unstable, matugen, helium, ... }:
  let
    system = "x86_64-linux";
    

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    pkgsUnstable = import unstable {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    buildToolsVersion = "34.0.0";

  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        {
          nixpkgs.config.allowUnfree = true;
          programs.steam.enable = true;

          environment.systemPackages = import ./packages.nix {
            inherit pkgs system;
            zen-browser = zen-browser;
            
          }++ [
            # packages from unstable go here like this pkgsUnstable.audacity
            matugen.packages.${system}.default
            helium.packages.${system}.default
            pkgsUnstable.tiny-wii-backup-manager
            pkgsUnstable.bottles
            pkgsUnstable.cisco-packet-tracer_9
          ];

          fonts.fontconfig.enable = true;
          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            ipafont #normal japanese font, the default one is pretty much unreadable
          ];
        }
      ];
    };
  };
}
