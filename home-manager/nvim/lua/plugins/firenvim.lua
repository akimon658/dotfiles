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
    ---@class filetypeConfig
    ---@field pattern string
    ---@field ft string

    ---@type filetypeConfig[]
    local configs = {
      {
        pattern = 'github.com_*',
        ft = 'markdown'
      },
      {
        pattern = 'go.dev_*',
        ft = 'go'
      }
    }

    for i in ipairs(configs) do
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = string.format('%s.txt', configs[i].pattern),
        callback = function()
          vim.opt_local.filetype = configs[i].ft
        end
      })
    end

    vim.g.firenvim_config = {
      localSettings = {
        [ [[.*]] ] = { takeover = 'never' },
        [ [[github\.com]] ] = { takeover = 'always' },
        [ [[github\.com.*blob]] ] = { takeover = 'never' },
        [ [[go\.dev]] ] = { takeover = 'always' }
      }
    }

    vim.opt.guifont = 'HackGen Console NF:h11'
  end
}

return firenvim
