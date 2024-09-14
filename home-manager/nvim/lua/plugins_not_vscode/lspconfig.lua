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
      -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
      {
        event = event.buf_write_pre,
        config = {
          group = vim.api.nvim_create_augroup("goimports", {}),
          callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)

            for cid, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encodint or "utf-16"
                  vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
              end
            end
          end,
          pattern = "*.go",
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

    local capabilities = require "cmp_nvim_lsp".default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

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
      "lua_ls",
      "nim_langserver",
      "texlab",
      "pylsp",
      "vuels",
      "yamlls",
      tsserver,
    }

    local schemastore = require "schemastore"
    local schemas = schemastore.json.schemas()

    for _, lsp in ipairs(servers) do
      lsp_config[lsp].setup {
        capabilities = capabilities,
        settings = {
          gopls = {
            ["local"] = goimports_local,
          },
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
            chktex = {
              onEdit = true,
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
