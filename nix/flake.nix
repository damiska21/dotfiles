{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zen-browser, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        android_sdk.accept_license = true;
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
          };

          fonts.fontconfig.enable = true;
          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
          ];
        }
      ];
    };

    devShell = pkgs.mkShell {
      ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
      buildInputs = [
        pkgs.flutter
        androidSdk
        pkgs.jdk11
      ];
    };
  };
}
