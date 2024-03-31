---@type LazyPluginSpec
local lualine = {
  "nvim-lualine/lualine.nvim",
  config = true,
  dependencies = {
    require "plugins.devicons",
    require "plugins.vscode",
  },
}

return lualine
