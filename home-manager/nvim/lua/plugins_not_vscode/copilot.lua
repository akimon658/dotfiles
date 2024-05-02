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
  event = require "vim_event".buf_read_post,
}

return copilot
