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
      dependencies = { require "plugins.vscode" },
    },
    require "plugins.nui",
    require "plugins.treesitter",
  },
}
return noice
