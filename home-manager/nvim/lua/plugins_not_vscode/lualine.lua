---@type LazyPluginSpec
local lualine = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    require "plugins_not_vscode.devicons",
    require "plugins_not_vscode.vscode",
  },
  opts = {
    options = {
      globalstatus = true,
    },
  },
}

return lualine
