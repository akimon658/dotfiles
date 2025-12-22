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
    interactions = {
      chat = {
        adapter = "gemini_cli",
      },
    },
    extensions = {
      history = {
        title_generation_opts = {
          adapter = "copilot",
          model = "gpt-4.1",
        },
      },
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
      },
      spinner = {},
    },
    memory = {
      opts = {
        chat = {
          enabled = true,
        },
      },
    },
  },
}
