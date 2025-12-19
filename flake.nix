{
  description = "A flake to provision @akimon658's environment";

  inputs = {
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.11";
    };
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
  };

  outputs = { self, home-manager, nix-darwin, nixpkgs }:
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
      ];
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
      };
    };
  };
}
