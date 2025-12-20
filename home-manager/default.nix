{ pkgs, ... }: let
  username = "akimon658";
in {
  home = {
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
      brewCasks.alt-tab
      unstable.gemini-cli
      nixd
    ];
    stateVersion = "25.11";
    username = username;
  };
}
