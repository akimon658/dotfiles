---@type LazyPluginSpec
local copilot = {
  "zbirenbaum/copilot.lua",
  config = function()
    require "copilot".setup {
      suggestion = {
        auto_trigger = true,
      },
    }
  end,
  cond = function()
    return string.find(vim.fn.getcwd(), "AtCoder") == nil
  end,
  event = require "vim_event".buf_read_post,
}

return copilot
