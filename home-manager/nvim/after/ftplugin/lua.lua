LspConfig.sumneko_lua.setup {
  capabilities = Capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
