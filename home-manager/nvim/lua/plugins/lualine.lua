---@type LazyPluginSpec
local lualine = {
  'nvim-lualine/lualine.nvim',
  config = true,
  dependencies = { require('plugins.devicons') }
}

return lualine
