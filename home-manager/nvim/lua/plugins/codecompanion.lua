---@type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    require "plugins.plenary",
  },
  keys = {
    {
      "<leader>c",
      function()
        require "codecompanion".toggle()
      end,
    },
  },
  opts = {
    extensions = {
      history = {},
      spinner = {},
    },
  },
}
