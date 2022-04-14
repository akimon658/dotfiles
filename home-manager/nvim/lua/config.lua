local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require('cmp').setup {
  sources = {
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
