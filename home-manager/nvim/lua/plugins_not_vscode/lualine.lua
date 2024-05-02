---@type LazyPluginSpec
local lualine = {
  "nvim-lualine/lualine.nvim",
  config = function()
    require "lualine".setup {
      options = {
        globalstatus = true,
      },
    }
  end,
  dependencies = {
    require "plugins_not_vscode.devicons",
    require "plugins_not_vscode.vscode",
  },
}

return lualine
