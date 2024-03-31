---@type LazyPluginSpec
local mkdir = {
  "jghauser/mkdir.nvim",
  event = require "vim_event".buf_new_file,
}

return mkdir
