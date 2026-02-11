{ pkgs, ... }: let
  username = "akimon658";
in {
  imports = [ ./nvim.nix ];

  home = {
    file = {
      ".hushlogin".text = "";
      ".local/share/cargo/config.toml".source = ./cargo/config.toml;
      # I primarily use fish, but Antigravity uses zsh,
      # so place minimal config containing PATH setup.
      ".zshrc".source = ./zsh/.zshrc;
    };
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
      brewCasks.alt-tab
      (curl.override {
        websocketSupport = true;
      })
      antigravity
      brewCasks.figma
      unstable.fish
      unstable.gemini-cli
      gh
      nodejs
      thunderbird
      (brewCasks.unity-hub.overrideAttrs (oldAttrs: {
        src = pkgs.fetchurl {
          url = builtins.head oldAttrs.src.urls;
          hash = "sha256-9rR97hWa3UyxXvuH2AoM70ttGt9udRd3CDy5Uj7DNgI="; # 3.15.4
        };
      }))
      (yt-dlp.override {
        rtmpSupport = false;
      })
    ];
    stateVersion = "25.11";
    username = username;
  };
  programs = {
    ghostty = {
      enable = true;
      package = pkgs.brewCasks.ghostty;
      settings = {
        background-opacity = 0.9;
        command = "${pkgs.unstable.fish}/bin/fish";
        font-family = [
          "Roboto Mono"
          "Noto Sans JP"
        ];
        macos-titlebar-style = "tabs";
        theme = "dark:One Double Dark, light:One Double Light";
      };
    };
    git = {
      enable = true;
      settings = {
        core.editor = "nvim";
        ghq.root = "~/Google Drive/マイドライブ/ghq";
        help.autocorrect = "50";
        user = {
          name = "Takumi Akimoto";
          email = "81888693+akimon658@users.noreply.github.com";
        };
      };
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINJUJW10aa7BhexEnWNWgRdzMHMh/rlODWF0H8SSBfmm";
        format = "ssh";
        signByDefault = true;
        signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      ignores = [ ".DS_Store" ];
    };
  };
  xdg.configFile = {
    "fish/config.fish".source = ./fish/config.fish;
    "zsh/.zshrc".source = ./zsh/.zshrc;
  };
}
