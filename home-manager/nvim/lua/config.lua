local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local cmp = require('cmp')
cmp.setup {
  mapping = {
    ['<Tab>'] = cmp.mapping.confirm {
      select = true
    }
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' }
  }
}

LspConfig = require('lspconfig')
local servers = {
  'denols',
  'gopls',
  'sumneko_lua'
}
for _, lsp in ipairs(servers) do
  LspConfig[lsp].setup {
    capabilities = capabilities
  }
end

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  }
}

vim.api.nvim_set_var('vscode_style', 'dark')
vim.cmd('colorscheme vscode')
vim.opt.wrap = false
