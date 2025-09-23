local event = require "vim_event"

---@type LazyPluginSpec
local lspconfig = {
  "neovim/nvim-lspconfig",
  config = function()
    local any_pattern = "*"

    ---@type autoCmd[]
    local autocmds = {
      {
        event = event.buf_write_pre,
        config = {
          group = vim.api.nvim_create_augroup("fmt", {}),
          callback = function()
            vim.lsp.buf.format {
              filter = function(client)
                return client.supports_method "textDocument/formatting"
              end,
            }
          end,
          pattern = any_pattern,
        },
      },
      -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
      -- https://zenn.dev/izumin/articles/b8046e64eaa2b5
      {
        event = event.buf_write_pre,
        config = {
          group = vim.api.nvim_create_augroup("organize_imports", {}),
          callback = function(args)
            local supported_clients = {
              "biome",
              "gopls",
            }

            for _, client in ipairs(vim.lsp.get_clients { bufnr = args.buf }) do
              if vim.tbl_contains(supported_clients, client.name) then
                local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
                params.context = { only = { "source.organizeImports" }, diagnostics = {} }
                local res = client.request_sync("textDocument/codeAction", params)

                for _, r in pairs(res and res.result or {}) do
                  if r.edit then
                    local enc = (vim.lsp.get_client_by_id(client.id) or {}).offset_encodint or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                  end
                end
              end
            end
          end,
          pattern = any_pattern,
        },
      },
      {
        event = "CursorHold",
        config = {
          group = vim.api.nvim_create_augroup("diagnostics_hover", {}),
          callback = function()
            if vim.diagnostic.is_enabled() then
              vim.diagnostic.open_float { focusable = false }
            end
          end,
          pattern = any_pattern,
        },
      },
    }

    local util = require "vim_util"
    for _, autocmd in ipairs(autocmds) do
      util.create_autocmd(autocmd)
    end
    local lsp_config = require "lspconfig"

    ---@type boolean
    local use_deno = vim.fn.filereadable(vim.fn.getcwd() .. "/deno.json") == 1 or
        vim.fn.filereadable(vim.fn.getcwd() .. "/deno.jsonc") == 1
    ---@type string
    local tsserver = use_deno and "denols" or "ts_ls"

    ---@type string
    local goimports_local
    ---@type string
    local gomod_path = vim.fn.getcwd() .. "/go.mod"
    if vim.fn.filereadable(gomod_path) == 1 then
      local f = io.open(gomod_path)

      if f then
        goimports_local = vim.split(f:read(), " ")[2]
      end
    end

    ---@type string[]
    local servers = {
      "bashls",
      "clangd",
      "cssls",
      "dockerls",
      "gopls",
      "jsonls",
      "lemminx",
      "pylsp",
      "rust_analyzer",
      "vacuum",
      tsserver,
    }

    local schemastore = require "schemastore"
    local schemas = schemastore.json.schemas()

    for _, lsp in ipairs(servers) do
      lsp_config[lsp].setup {
        settings = {
          gopls = {
            ["local"] = goimports_local,
          },
          json = {
            schemas = schemas,
            validate = { enable = true },
          },
          pylsp = {
            plugins = {
              autopep8 = { enabled = false },
            },
          },
        },
      }
    end

    lsp_config.powershell_es.setup {
      bundle_path = "C:/PowerShellEditorServices",
    }

    lsp_config.tinymist.setup {
      settings = {
        formatterMode = "typstyle",
      },
    }

    lsp_config.yamlls.setup {
      filetypes = {
        "yaml",
        "yaml.docker-compose",
        "yaml.gitlab",
        "yaml.openapi", -- Added
      },
      settings = {
        yaml = { keyOrdering = false },
      },
    }
  end,
  dependencies = {
    "b0o/schemastore.nvim",
  },
  event = {
    event.buf_new_file,
    event.buf_read_pre,
  },
  keys = {
    {
      "<leader>a",
      vim.lsp.buf.code_action,
    },
    {
      "<leader>h",
      vim.lsp.buf.hover,
    },
    {
      "<leader>rn",
      vim.lsp.buf.rename,
    },
  },
}

return lspconfig
