local event = require('vim_event')

---@type LazyPluginSpec
local lspconfig = {
  'neovim/nvim-lspconfig',
  config = function()
    local lsp_config = require('lspconfig')

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    ---@type boolean
    local use_deno = vim.fn.filereadable(vim.fn.getcwd() .. '/deno.json') == 1
    ---@type string
    local tsserver = use_deno and 'denols' or 'tsserver'

    ---@type string[]
    local servers = {
      'bashls',
      'clangd',
      'cssls',
      'dockerls',
      'gopls',
      'jsonls',
      'lemminx',
      'lua_ls',
      'nimls',
      'pylsp',
      'yamlls',
      tsserver
    }

    local schemastore = require('schemastore')

    for _, lsp in ipairs(servers) do
      lsp_config[lsp].setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true }
          },
          yaml = { keyOrdering = false }
        }
      })
    end

    lsp_config.powershell_es.setup({
      bundle_path = 'C:/PowerShellEditorServices',
      capabilities = capabilities
    })
  end,
  dependencies = {
    'b0o/schemastore.nvim',
    'hrsh7th/cmp-nvim-lsp'
  },
  event = {
    event.buf_new_file,
    event.buf_read_pre
  },
  keys = {
    {
      '<leader>h',
      vim.lsp.buf.hover
    },
    {
      '<leader>rf',
      vim.lsp.buf.references
    },
    {
      '<leader>rn',
      vim.lsp.buf.rename
    }
  }
}

return lspconfig
