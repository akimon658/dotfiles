---@type LazyPluginSpec
local treesitter = {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  config = function()
    require('nvim-treesitter.configs').setup {
      auto_install = true,
      -- For noice.nvim (https://github.com/folke/noice.nvim#%EF%B8%8F-requirements)
      ensure_installed = {
        'bash',
        'lua',
        'markdown',
        'markdown_inline',
        'regex',
        'vim'
      },
      sync_install = true,
      highlight = {
        enable = true
      }
    }

    require('nvim-treesitter.install').prefer_git = false
  end,
  event = require('vim_event').buf_read_pre
}

return treesitter
