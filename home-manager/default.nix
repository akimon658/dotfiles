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
      unstable.fish
      unstable.gemini-cli
      nixd
      (brewCasks.unity-hub.overrideAttrs (oldAttrs: {
        src = pkgs.fetchurl {
          url = builtins.head oldAttrs.src.urls;
          hash = "sha256-9rR97hWa3UyxXvuH2AoM70ttGt9udRd3CDy5Uj7DNgI="; # 3.15.4
        };
      }))
    ];
    stateVersion = "25.11";
    username = username;
  };
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm/wezterm.lua;
    package = pkgs.brewCasks.wezterm;
  };
  xdg.configFile = {
    "fish/config.fish".source = ./xdg_config/fish/config.fish;
  };
}
