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
                return client.server_capabilities.documentFormattingProvider ~= nil
              end,
            }
          end,
          pattern = any_pattern,
        },
      },
      {
        event = "CursorHold",
        config = {
          group = vim.api.nvim_create_augroup("diagnostics_hover", {}),
          callback = function()
            if not vim.diagnostic.is_disabled() then
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

    local capabilities = require "cmp_nvim_lsp".default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    ---@type boolean
    local use_deno = vim.fn.filereadable(vim.fn.getcwd() .. "/deno.json") == 1
    ---@type string
    local tsserver = use_deno and "denols" or "tsserver"

    ---@type string[]
    local servers = {
      "bashls",
      "clangd",
      "cssls",
      "dockerls",
      "gopls",
      "jsonls",
      "lemminx",
      "lua_ls",
      "nimls",
      "texlab",
      "pylsp",
      "yamlls",
      tsserver,
    }

    local schemastore = require "schemastore"
    local schemas = schemastore.json.schemas()

    for _, lsp in ipairs(servers) do
      lsp_config[lsp].setup {
        capabilities = capabilities,
        settings = {
          json = {
            schemas = schemas,
            validate = { enable = true },
          },
          texlab = {
            build = {
              args = {
                "-synctex=1",
                "%f",
              },
              onSave = true,
            },
          },
          yaml = { keyOrdering = false },
        },
      }
    end

    lsp_config.powershell_es.setup {
      bundle_path = "C:/PowerShellEditorServices",
      capabilities = capabilities,
    }
  end,
  dependencies = {
    "b0o/schemastore.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  event = {
    event.buf_new_file,
    event.buf_read_pre,
  },
  keys = {
    {
      "<leader>h",
      vim.lsp.buf.hover,
    },
    {
      "<leader>rf",
      vim.lsp.buf.references,
    },
    {
      "<leader>rn",
      vim.lsp.buf.rename,
    },
  },
}

return lspconfig
