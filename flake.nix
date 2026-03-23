{
  description = "A flake to provision @akimon658's environment";

  inputs = {
    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.brew-api.follows = "brew-api";
    };
    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.11";
    };
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim/nixos-25.11";
    };
  };

  outputs = { self, brew-nix, home-manager, nix-darwin, nixpkgs, nixpkgs-unstable, nixvim, ... }:
  {
    darwinConfigurations.Nozomi = nix-darwin.lib.darwinSystem {
      modules = [
        ./darwin
      ];
      specialArgs = { inherit self; };
    };

    homeConfigurations.akimon658 = home-manager.lib.homeManagerConfiguration {
      modules = [
        ./home-manager
        nixvim.homeModules.nixvim
        {
          nixpkgs.overlays = [
            brew-nix.overlays.default
            (final: _prev: {
              unstable = import nixpkgs-unstable {
                  config.allowUnfree = true;
                system = final.stdenv.hostPlatform.system;
              };
            })
          ];
        }
      ];
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        system = "aarch64-darwin";
      };
    };
  };
}
