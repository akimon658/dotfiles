---@type LazyPluginSpec
local noice = {
  "folke/noice.nvim",
  config = true,
  dependencies = {
    {
      "rcarriga/nvim-notify",
      config = function()
        require "notify".setup { stages = "static" }
      end,
      dependencies = { require "plugins_not_vscode.vscode" },
    },
    require "plugins_not_vscode.nui",
    require "plugins_not_vscode.treesitter",
  },
}
return noice
