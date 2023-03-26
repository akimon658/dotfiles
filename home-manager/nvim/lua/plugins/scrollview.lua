local event = require('vim_event')

---@type LazyPluginSpec
local scrollview = {
  'dstein64/nvim-scrollview',
  config = function()
    vim.api.nvim_set_hl(0, 'ScrollView', { link = 'TermCursor' })
    vim.g.scrollview_column = 1
  end,
  event = {
    event.buf_new_file,
    event.buf_read_pre
  }
}

return scrollview
