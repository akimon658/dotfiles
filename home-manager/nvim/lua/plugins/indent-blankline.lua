local event = require('vim_event')

---@type LazyPluginSpec
local indent_blankline = {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    local link_to_non_text = { link = 'NonText' }
    vim.api.nvim_set_hl(0, 'IblIndent', link_to_non_text)
    vim.api.nvim_set_hl(0, 'IblScope', { fg = '#dcdcaa' })
    vim.api.nvim_set_hl(0, 'IblWhitespace', link_to_non_text)
  end,
  dependencies = { require('plugins.treesitter') },
  event = {
    event.buf_new_file,
    event.buf_read_pre
  },
  main = 'ibl',
}

return indent_blankline
