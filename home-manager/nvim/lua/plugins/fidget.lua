---@type LazyPluginSpec
return {
  "j-hui/fidget.nvim",
  event = require "vim_event".lsp_attach,
  opts = {
    notification = {
      window = {
        winblend = 0,
      },
    },
  },
}
