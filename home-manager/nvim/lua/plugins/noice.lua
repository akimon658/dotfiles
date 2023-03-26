---@type LazyPluginSpec
local noice = {
  'folke/noice.nvim',
  config = true,
  dependencies = {
    {
      'rcarriga/nvim-notify',
      config = function()
        require('notify').setup({
          background_colour = '#000000',
          stages = 'fade'
        })
      end
    },
    require('plugins.nui'),
    require('plugins.treesitter')
  }
}
return noice
