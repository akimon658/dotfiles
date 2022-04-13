LspConfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
