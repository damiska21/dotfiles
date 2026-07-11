{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    affinity-nix.url = "github:mrshmllow/affinity-nix";
    matugen.url = "github:InioX/Matugen";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    musnix  = { url = "github:musnix/musnix"; };
  };

  outputs = { self, nixpkgs, nixos-hardware, musnix,  zen-browser, unstable, affinity-nix, matugen, helium, ... }:
  let
    system = "x86_64-linux";
    

    pkgs = import nixpkgs {
      inherit system;
      config = {
        android_sdk.accept_license = true;
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

    androidComposition = pkgs.androidenv.composeAndroidPackages {
      buildToolsVersions = [ buildToolsVersion ];
      platformVersions   = [ "34" ];
      abiVersions        = [ "arm64-v8a" ];
    };

    androidSdk = androidComposition.androidsdk;

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
            affinity-nix.packages.${system}.v3
            matugen.packages.${system}.default
            helium.packages.${system}.default
          ];

          fonts.fontconfig.enable = true;
          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            ipafont #normal japanese font, the default one is pretty much unreadable
          ];
        }
        nixos-hardware.nixosModules.lenovo-ideapad-15arh05
        musnix.nixosModules.musnix
      ];
    };
  };
}
