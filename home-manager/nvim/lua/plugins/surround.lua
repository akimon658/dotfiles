local event = require "vim_event"

---@type LazyPluginSpec
local surround = {
  "kylechui/nvim-surround",
  config = true,
  event = {
    event.buf_new_file,
    event.buf_read_post,
  },
}

return surround
