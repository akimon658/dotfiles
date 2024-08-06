local event = require "vim_event"

---@type LazyPluginSpec
local surround = {
  "kylechui/nvim-surround",
  event = {
    event.buf_new_file,
    event.buf_read_post,
  },
  opts = {},
}

return surround
