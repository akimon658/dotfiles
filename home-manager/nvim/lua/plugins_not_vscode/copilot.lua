---@type LazyPluginSpec
local copilot = {
  "zbirenbaum/copilot.lua",
  cond = function()
    return string.find(vim.fn.getcwd(), "AtCoder") == nil
  end,
  event = require "vim_event".buf_read_post,
  opts = {
    filetypes = {
      markdown = true,
    },
    suggestions = {
      auto_trigger = true,
    },
  },
}

return copilot
