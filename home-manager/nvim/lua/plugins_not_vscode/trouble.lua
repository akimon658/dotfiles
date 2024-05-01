---@type LazyPluginSpec
local trouble = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = { {
    "<leader>m",
    function()
      require "trouble".toggle()
    end,
  } },
}

return trouble
