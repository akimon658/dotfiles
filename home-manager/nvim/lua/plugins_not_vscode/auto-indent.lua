local vim_event = require "vim_event"

---@type LazyPluginSpec
local auto_indent = {
  "VidocqH/auto-indent.nvim",
  config = true,
  event = vim_event.insert_enter,
}

return auto_indent
