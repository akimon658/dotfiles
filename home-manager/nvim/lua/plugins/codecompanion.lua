---@type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  cmd = {
    "CodeCompanionChat",
  },
  dependencies = {
    require "plugins.plenary",
  },
  opts = {},
}
