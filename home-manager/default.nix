{ pkgs, lib, ... }: let
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
      brewCasks.zoom
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
    starship = {
      enable = true;
      settings = {
        format = lib.strings.concatStrings [
            "$os"
            "[](bg:#769ff0 fg:#a3aed2)"
            "$nix_shell"
            "$directory"
            "[](fg:#769ff0 bg:#394260)"
            "$git_branch"
            "$git_status"
            "[](fg:#394260 bg:#212736)"
            "$deno"
            "$nodejs"
            "$rust"
            "$golang"
            "$php"
            "$python"
            "[](fg:#212736 bg:#1d2230)"
            "$time"
            "[ ](fg:#1d2230)"
          ] + "\n$character";
        deno = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        directory = {
          style = "fg:#e3e5e5 bg:#769ff0";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            Documents = "󰈙 ";
            Downloads = " ";
            Music = " ";
            Pictures = " ";
          };
        };
        git_branch = {
          symbol = "";
          style = "bg:#394260";
          format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
        };
        git_status = {
          style = "bg:#394260";
          format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
        };
        nix_shell = {
          symbol = "";
          style = "fg:769ff0 bg:#769ff0";
          format = "[[ $symbol ](fg:#e3e5e5 bg:#769ff0)]($style)";
        };
        nodejs = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
          # Exclude .js and .ts from default detaction
          detect_extensions = [
            "mjs"
            "cjs"
            "mts"
            "cts"
          ];
        };
        rust = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        golang = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        php = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        python = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version)( \\($virtualenv\\)) ](fg:#769ff0 bg:#212736)]($style)";
        };
        time = {
          disabled = false;
          time_format = "%R"; # Hour:Minute Format
          style = "bg:#1d2230";
          format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
        };
        os = {
          disabled = false;
          format = "[ $symbol ](bg:#a3aed2 fg:#090c0c)";
          symbols = {
            Arch = "󰣇";
            Macos = "";
            Ubuntu = "";
          };
        };
      };
    };
  };
}
