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
        {
          nix.settings.experimental-features = "nix-command flakes";
          nixpkgs.hostPlatform = "aarch64-darwin";
          programs.fish.enable = true;
          system = {
            configurationRevision = self.rev or self.dirtyRev or null;
            stateVersion = 6;
          };
        }
        home-manager.darwinModules.home-manager
      ];
    };
  };
}
