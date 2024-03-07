---@type LazyPluginSpec
local noice = {
  'folke/noice.nvim',
  cond = not vim.g.started_by_firenvim,
  config = true,
  dependencies = {
    {
      'rcarriga/nvim-notify',
      config = function()
        require('notify').setup({ stages = 'static' })
      end,
      dependencies = { require 'plugins.vscode' },
    },
    require('plugins.nui'),
    require('plugins.treesitter')
  }
}
return noice
