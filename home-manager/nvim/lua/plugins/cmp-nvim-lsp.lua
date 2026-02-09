---@type LazyPluginSpec
return {
  "hrsh7th/cmp-nvim-lsp",
  config = function()
    local capabilities = require "cmp_nvim_lsp".default_capabilities()

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end,
  lazy = true,
}
