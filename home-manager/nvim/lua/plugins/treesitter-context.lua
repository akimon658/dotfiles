---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = require "vim_event".buf_read_pre,
  dependencies = {
    require "plugins.treesitter",
  },
}
