---@type LazyPluginSpec
local firenvim = {
  'glacambre/firenvim',
  build = function()
    require('lazy').load({
      plugins = 'firenvim',
      wait = true
    })
    vim.fn['firenvim#install'](0)
  end,
  cond = not not vim.g.started_by_firenvim,
  config = function()
    vim.opt.guifont = 'HackGen Console NF:h11'
  end
}

return firenvim
