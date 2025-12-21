{ pkgs, ... }: let
  username = "akimon658";
in {
  home = {
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
      brewCasks.alt-tab
      (curl.override {
        websocketSupport = true;
      })
      brewCasks.figma
      unstable.gemini-cli
      nixd
    ];
    stateVersion = "25.11";
    username = username;
  };
}
