local event = require('vim_event')

---@type LazyKeys[]
local keys = {
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
  },
  {
    '<leader>t0',
    '<Cmd>BufferLast<CR>'
  }
}
for i = 1, 9 do
  table.insert(keys, {
    string.format('<leader>t%d', i),
    string.format('<Cmd>BufferGoto %d<CR>', i)
  })
end

---@type LazyPluginSpec
local barbar = {
  'romgrk/barbar.nvim',
  dependencies = { require('plugins.devicons') },
  event = {
    event.buf_new_file,
    event.buf_read_pre
  },
  keys = keys
}

return barbar
