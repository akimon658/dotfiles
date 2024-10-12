local event = require "vim_event"

---@type LazyPluginSpec
local gitsigns = {
  "lewis6991/gitsigns.nvim",
  event = { event.buf_new_file,
    event.buf_read_pre,
  },
  opts = {},
}

return gitsigns
