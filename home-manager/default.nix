{ pkgs, ... }: let
  username = "akimon658";
in {
  imports = [ ./nvim.nix ];

  home = {
    file = {
      ".hushlogin".text = "";
      ".local/share/cargo/config.toml".source = ./cargo/config.toml;
    };
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
      brewCasks.alt-tab
      (curl.override {
        websocketSupport = true;
      })
      antigravity
      codex
      codex-acp
      deno
      (ffmpeg-headless.override {
        buildFfprobe = false;
      })
      brewCasks.figma
      unstable.gemini-cli
      gh
      gopls # To use with Antigravity's Go extension
      nodejs
      thunderbird
      (brewCasks.unity-hub.overrideAttrs (oldAttrs: {
        src = pkgs.fetchurl {
          url = builtins.head oldAttrs.src.urls;
          hash = "sha256-jQ6svEXqgL3sgXywd/E44uX5Sdl6lBc70nvq9DMROSQ="; # 3.16.3
        };
      }))
      (yt-dlp.override {
        rtmpSupport = false;
      })
    ];
    sessionVariables = {
      GOCACHE = "/tmp/go-build";
    };
    stateVersion = "25.11";
    username = username;
  };
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fish = {
      enable = true;
      loginShellInit = builtins.readFile ./fish/config.fish;
      package = pkgs.unstable.fish; # v4.3+ to get the auto theme support
    };
    ghostty = {
      enable = true;
      package = pkgs.ghostty-bin;
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
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
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
      ignores = [
        ".direnv"
        ".DS_Store"
        ".envrc"
      ];
    };
  };
}
