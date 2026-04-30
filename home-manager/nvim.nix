{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    plugins.lz-n.enable = true;
    globals.mapleader = " ";
    opts = {
      cmdheight = 0;
      cursorline = true;
      expandtab = true;
      fileformats = "unix,dos";
      fillchars = { eob = " "; };
      laststatus = 3;
      list = true;
      listchars = {
        eol = "↲";
        precedes = "<";
        space = "･";
        tab = "> ";
      };
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      signcolumn = "yes";
      splitright = true;
      tabstop = 4;
      updatetime = 1000;
      winborder = "rounded";
      wrap = false;
    };
    highlightOverride = {
      CursorLine = { bg = "#444444"; };
    };
    diagnostic.settings = {
      signs = {
        text = {
          "ERROR" = "";
          "WARN" = "";
          "INFO" = "";
          "HINT" = "";
        };
      };
      virtual_lines.current_line = true;
    };
    keymaps = [
      {
        mode = "t";
        key = "<Esc>";
        action = "<C-\\><C-n>";
        options.noremap = true;
      }
    ];
    filetype = {
      extension = {
        mdx = "markdown.mdx";
      };
      pattern = {
        "Caddyfile" = "caddy";
        "openapi.*%.ya?ml" = "yaml.openapi";
      };
    };
    files = {
      "after/ftplugin/caddy.lua" = {
        opts = { expandtab = false; shiftwidth = 4; };
      };
      "after/ftplugin/dockerfile.lua" = {
        opts = { shiftwidth = 4; };
      };
      "after/ftplugin/gitconfig.lua" = {
        opts = { expandtab = false; shiftwidth = 4; };
      };
      "after/ftplugin/go.lua" = {
        opts = { expandtab = false; shiftwidth = 4; };
      };
      "after/ftplugin/markdown.lua" = {
        opts = { wrap = true; };
      };
      "after/ftplugin/markdown.mdx.lua" = {
        opts = { wrap = true; };
      };
      "after/ftplugin/text.lua" = {
        opts = { wrap = true; };
      };
    };
    autoCmd = [
      {
        event = "InsertLeave";
        group = "disable_ime";
        pattern = "*";
        callback.__raw = ''
          function()
            local uname = vim.uv.os_uname()
            local sysname = uname.sysname
            local is_windows = sysname == "Windows_NT"
            local is_wsl = sysname == "Linux" and string.find(uname.release, "microsoft") ~= nil
            local is_mac = sysname == "Darwin"
            local im_disable_cmd = ""

            if is_windows or is_wsl then
              im_disable_cmd = "zenhan.exe 0"
            elseif is_mac then
              im_disable_cmd = "osascript -e 'tell application \"System Events\" to key code 102'"
            end

            if im_disable_cmd ~= "" then
              os.execute(im_disable_cmd)
            end
          end
        '';
      }
    ];
    autoGroups = {
      disable_ime = {};
    };
    performance.byteCompileLua.enable = true;
    extraConfigLuaPre = ''
      -- https://zenn.dev/vim_jp/articles/c96e9b1bdb9241
      vim.env.XDG_STATE_HOME = "/tmp"
    '';
    extraFiles = {
      "lua/custom/autopairs-setup.lua".source = ./nvim/lua/custom/autopairs-setup.lua;
      "lua/custom/cmp-setup.lua".source = ./nvim/lua/custom/cmp-setup.lua;
      "lua/custom/telescope-setup.lua".source = ./nvim/lua/custom/telescope-setup.lua;
      "lua/custom/lualine-setup.lua".source = ./nvim/lua/custom/lualine-setup.lua;
      "lua/custom/lsp-autocmds.lua".source = ./nvim/lua/custom/lsp-autocmds.lua;
      "lua/custom/vscode-setup.lua".source = ./nvim/lua/custom/vscode-setup.lua;
      "after/ftplugin/typst.lua".source = ./nvim/after/ftplugin/typst.lua;
    };
    colorscheme = "vscode";
    colorschemes.vscode = {
      enable = true;
      luaConfig.content = ''
        require("custom.vscode-setup")
      '';
    };
    plugins = {
      nvim-autopairs = {
        enable = true;
        settings.map_c_h = true;
        lazyLoad.settings.event = [ "BufNewFile" "BufReadPost" ];
        luaConfig.post = ''require("custom.autopairs-setup")'';
      };
      barbar = {
        enable = true;
        lazyLoad.settings = {
          event = [ "BufNewFile" "BufReadPre" "TermOpen" ];
          keys = [
            { __unkeyed-1 = "<leader>w";  __unkeyed-2 = "<Cmd>BufferClose<CR>"; }
            { __unkeyed-1 = "<leader>.";  __unkeyed-2 = "<Cmd>BufferNext<CR>"; }
            { __unkeyed-1 = "<leader>,";  __unkeyed-2 = "<Cmd>BufferPrevious<CR>"; }
            { __unkeyed-1 = "<leader>>";  __unkeyed-2 = "<Cmd>BufferMoveNext<CR>"; }
            { __unkeyed-1 = "<leader><";  __unkeyed-2 = "<Cmd>BufferMovePrevious<CR>"; }
            { __unkeyed-1 = "<leader>t0"; __unkeyed-2 = "<Cmd>BufferLast<CR>"; }
            { __unkeyed-1 = "<leader>t1"; __unkeyed-2 = "<Cmd>BufferGoto 1<CR>"; }
            { __unkeyed-1 = "<leader>t2"; __unkeyed-2 = "<Cmd>BufferGoto 2<CR>"; }
            { __unkeyed-1 = "<leader>t3"; __unkeyed-2 = "<Cmd>BufferGoto 3<CR>"; }
            { __unkeyed-1 = "<leader>t4"; __unkeyed-2 = "<Cmd>BufferGoto 4<CR>"; }
            { __unkeyed-1 = "<leader>t5"; __unkeyed-2 = "<Cmd>BufferGoto 5<CR>"; }
            { __unkeyed-1 = "<leader>t6"; __unkeyed-2 = "<Cmd>BufferGoto 6<CR>"; }
            { __unkeyed-1 = "<leader>t7"; __unkeyed-2 = "<Cmd>BufferGoto 7<CR>"; }
            { __unkeyed-1 = "<leader>t8"; __unkeyed-2 = "<Cmd>BufferGoto 8<CR>"; }
            { __unkeyed-1 = "<leader>t9"; __unkeyed-2 = "<Cmd>BufferGoto 9<CR>"; }
          ];
        };
        luaConfig.post = ''
          vim.api.nvim_set_hl(0, "BufferTabpageFill", {})
        '';
      };
      cmp = {
        enable = true;
        luaConfig.content = ''require("custom.cmp-setup")'';
      };
      cmp-cmdline.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lua.enable = true;
      cmp-path.enable = true;
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      lspkind.enable = true;
      codecompanion = {
        enable = true;
        lazyLoad.settings.keys = [
          {
            __unkeyed-1 = "<leader>c";
            __unkeyed-2.__raw = ''
              function()
                require("codecompanion").toggle()
              end
            '';
          }
        ];
        settings = {
          strategies.chat.adapter = "gemini_cli";
          adapters.acp.codex.__raw = ''
            function()
              return require "codecompanion.adapters".extend("codex", {
                defaults = {
                  auth_method = "chatgpt"
                },
              })
            end
          '';
          extensions = {
            history.opts.title_generation_opts = {
              adapter = "copilot";
              model = "gpt-4.1";
            };
            spinner = {};
          };
          memory.opts.chat.enabled = true;
        };
      };
      copilot-lua = {
        enable = true;
        lazyLoad.settings.event = [ "BufReadPost" ];
        settings = {
          filetypes = {
            markdown = true;
            yaml = true;
          };
          suggestion = {
            auto_trigger = true;
            keymap.accept = "<C-f>";
          };
        };
        luaConfig.post = ''
          -- Disable copilot in competitive programming directories
          if string.find(vim.fn.getcwd(), "AtCoder") or string.find(vim.fn.getcwd(), "project%-euler") then
            require("copilot.command").disable()
          end
        '';
      };
      fidget = {
        enable = true;
        lazyLoad.settings.event = [ "LspAttach" ];
        settings.notification.window.winblend = 0;
      };
      gitsigns = {
        enable = true;
        lazyLoad.settings.event = [ "BufNewFile" "BufReadPre" ];
      };
      lualine = {
        enable = true;
        luaConfig.content = ''require("custom.lualine-setup")'';
      };
      neo-tree = {
        enable = true;
        lazyLoad.settings.keys = [
          {
            __unkeyed-1 = "<C-e>";
            __unkeyed-2.__raw = ''
              function()
                require("neo-tree.command")._command("toggle")
              end
            '';
          }
        ];
        settings = {
          close_if_last_window = true;
          default_component_configs.git_status.symbols.deleted = "";
          filesystem = {
            filtered_items.visible = true;
            follow_current_file.enabled = true;
            use_libuv_file_watcher = true;
          };
          view.relativenumber = true;
          window.width = 30;
        };
      };
      neogit = {
        enable = true;
        lazyLoad.settings.keys = [
          {
            __unkeyed-1 = "<C-g>";
            __unkeyed-2.__raw = ''
              function()
                require("neogit").open()
              end
            '';
          }
        ];
      };
      render-markdown = {
        enable = true;
        lazyLoad.settings.ft = [ "codecompanion" "markdown" ];
        settings = {
          file_types = [ "codecompanion" "markdown" ];
          heading = {
            backgrounds = [ "None" "None" "None" "None" "None" "None" ];
            icons = [ "# " "## " "### " "#### " "##### " "###### " ];
            sign = false;
          };
        };
      };
      nvim-surround = {
        enable = true;
        lazyLoad.settings.event = [ "BufNewFile" "BufReadPost" ];
      };
      telescope = {
        enable = true;
        lazyLoad.settings = {
          cmd = "Telescope";
          keys = [
            {
              __unkeyed-1 = "<C-f>";
              __unkeyed-2.__raw = ''
                function()
                  require("telescope.builtin").current_buffer_fuzzy_find()
                end
              '';
            }
            {
              __unkeyed-1 = "<C-p>";
              __unkeyed-2.__raw = ''
                function()
                  require("telescope.builtin").find_files()
                end
              '';
            }
            {
              __unkeyed-1 = "<leader>f";
              __unkeyed-2.__raw = ''
                function()
                  require("telescope.builtin").live_grep()
                end
              '';
            }
            {
              __unkeyed-1 = "<leader>rf";
              __unkeyed-2.__raw = ''
                function()
                  require("telescope.builtin").lsp_references()
                end
              '';
            }
            {
              __unkeyed-1 = "<leader>?";
              __unkeyed-2.__raw = ''
                function()
                  require("telescope.builtin").help_tags()
                end
              '';
            }
          ];
        };
        luaConfig.content = ''require("custom.telescope-setup")'';
      };
      telescope.extensions.ui-select.enable = true;
      treesitter = {
        enable = true;
        lazyLoad.settings.event = [ "BufReadPre" ];
        settings = {
          indent.enable = true;
          highlight.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          asm
          dockerfile
          gitcommit
          go
          markdown
          markdown_inline
          nix
          python
          rust
          sql
          tsx
          typescript
          yaml
        ];
      };
      treesitter-context = {
        enable = true;
        lazyLoad.settings.event = [ "BufReadPre" ];
        settings.multiwindow = true;
      };
      trouble = {
        enable = true;
        lazyLoad.settings.keys = [
          {
            __unkeyed-1 = "<leader>m";
            __unkeyed-2.__raw = ''
              function()
                require("trouble").toggle("diagnostics")
              end
            '';
          }
        ];
      };
      ts-autotag = {
        enable = true;
        lazyLoad.settings.ft = [ "html" "typescriptreact" ];
      };
      octo = {
        enable = true;
        lazyLoad.settings.cmd = "Octo";
      };
      web-devicons.enable = true;
      schemastore = {
        enable = true;
        json.enable = true;
        yaml.enable = true;
      };
      lsp = {
        enable = true;
        inlayHints = true;
        keymaps = {
          lspBuf = {
            "<leader>a" = "code_action";
            "<leader>df" = "definition";
            "<leader>h" = "hover";
            "<leader>rn" = "rename";
          };
        };
        servers = {
          clangd.enable = true;
          denols = {
            enable = true;
            rootMarkers = [ "deno.json" "deno.jsonc" ];
            settings.typescript.inlayHints = {
              enumMemberValues.enabled = true;
              functionLikeReturnTypes.enabled = true;
              parameterNames = {
                enabled = "all";
                suppressWhenArgumentMatchesName = true;
              };
              parameterTypes.enabled = true;
              propertyDeclarationTypes.enabled = true;
              variableTypes = {
                enabled = true;
                suppressWhenTypeMatchesName = true;
              };
            };
          };
          docker_language_server.enable = true;
          golangci_lint_ls = {
            enable = true;
            rootMarkers = [ ".golangci.yml" ".golangci.yaml" ".golangci.toml" ".golangci.json" ];
            extraOptions.workspace_required = true;
          };
          gopls = {
            enable = true;
            settings.gopls = {
              hints = {
                assignVariableTypes = true;
                compositeLiteralFields = true;
                compositeLiteralTypes = true;
                constantValues = true;
                functionTypeParameters = true;
                ignoredError = true;
                parameterNames = true;
                rangeVariableTypes = true;
              };
            };
            # goimports local setting is handled dynamically in lsp-autocmds
          };
          jsonls = {
            enable = true;
            filetypes = [ "json" "jsonc" "json5" ];
          };
          lua_ls = {
            enable = true;
            settings.Lua.hint = {
              enable = true;
              setType = true;
            };
          };
          metals = {
            enable = true;
            settings.metals.inlayHints = {
              byNameParameters.enable = true;
              hintsInPatternMatch.enable = true;
              hintsXRayMode.enable = true;
              implicitArguments.enable = true;
              implicitConversions.enable = true;
              inferredTypes.enable = true;
              namedParameters.enable = true;
              typeParameters.enable = true;
            };
          };
          nixd.enable = true;
          pylsp.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            settings."rust-analyzer".inlayHints = {
              bindingModeHints.enable = true;
              chainingHints.enable = true;
              closingBraceHints.enable = true;
              closureCaptureHints.enable = true;
              closureReturnTypeHints.enable = true;
              discriminantHints.enable = true;
              expressionAdjustmentHints.enable = true;
              genericParameterHints = {
                lifetime.enable = true;
                type.enable = true;
              };
              implicitDrops.enable = true;
              implicitSizedBoundHints.enable = true;
              lifetimeElisionHints.enable = true;
              rangeExclusiveHints.enable = true;
              reborrowHints.enable = true;
            };
          };
          tinymist.enable = true;
          ts_ls = {
            enable = true;
            rootMarkers = [ "tsconfig.json" ];
          };
          yamlls = {
            enable = true;
          };
        };
      };
    };
    extraConfigLuaPost = ''require("custom.lsp-autocmds")'';
    extraPlugins = with pkgs.vimPlugins; [
      codecompanion-history-nvim
      codecompanion-spinner-nvim
      copilot-lualine
      hex-nvim
      img-clip-nvim
      nvim-lsp-file-operations
      nvim-scrollview
      typst-preview-nvim
      vimade
    ];
    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "ScrollView", { background = "#666666" })
      vim.g.scrollview_column = 1
      require("hex").setup({})
      require("img-clip").setup({
        filetypes = {
          codecompanion = {
            dir_path = os.getenv("TMPDIR") .. "/img-clip.nvim/",
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      })
      require("vimade").setup({
        blocklist = {
          default = function(_, active)
            if active and active.buf_opts.filetype ~= "TelescopePrompt" then
              return true
            end
            return false
          end,
        },
        recipe = {
          "default",
          { animate = true },
        },
      })
    '';
  };
}
