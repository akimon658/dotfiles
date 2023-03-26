local event = require('vim_event')

---@type LazyPluginSpec
local barbar = {
  'romgrk/barbar.nvim',
  dependencies = { require('plugins.devicons') },
  event = {
    event.buf_new_file,
    event.buf_read_pre
  },
  keys = {
    {
      '<leader>c',
      '<Cmd>BufferClose<CR>'
    },
    {
      '<leader>.',
      '<Cmd>BufferNext<CR>'
    },
    {
      '<leader>,',
      '<Cmd>BufferPrevious<CR>'
    }
  }
}

return barbar
