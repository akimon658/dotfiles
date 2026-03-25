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
      firefox
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
    claude-code = {
      enable = true;
      package = pkgs.unstable.claude-code;
      settings = {
        enabledPlugins."gopls-lsp@claude-plugins-official" = true;
        statusLine = {
          type = "command";
          command = ''jq -r '"Context: \(.context_window.used_percentage // 0 | tostring | split(".") | .[0])% used | Model: \(.model.display_name)"' '';
        };
      };
    };
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
          email = "noreply@akimo.dev";
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
