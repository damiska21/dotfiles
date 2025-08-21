{
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
          nixpkgs.config.allowUnfree = true;
          programs.steam.enable   = true;
          # Install your system packages
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
      }; #nixosSystem
  }; #in
}
