{
  description = "A flake to provision @akimon658's environment";

  inputs = {
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs }:
  {
    darwinConfigurations."Nozomi" = nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        ./darwin
      ];
      specialArgs = { inherit self; };
    };
  };
}
