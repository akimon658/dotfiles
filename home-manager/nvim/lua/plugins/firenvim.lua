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
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'github.com_*.txt',
      callback = function()
        vim.opt_local.filetype = 'markdown'
      end
    })

    vim.g.firenvim_config = {
      localSettings = {
        [ [[.*]] ] = { takeover = 'never' },
        [ [[github\.com]] ] = { takeover = 'always' },
        [ [[github\.com.*blob]] ] = { takeover = 'never' }
      }
    }

    vim.opt.guifont = 'HackGen Console NF:h11'
  end
}

return firenvim
