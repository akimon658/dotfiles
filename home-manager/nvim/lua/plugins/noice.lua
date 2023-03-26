---@type LazyPluginSpec
local noice = {
  'folke/noice.nvim',
  config = true,
  dependencies = {
    require('plugins.nui'),
    require('plugins.treesitter')
  }
}
return noice
