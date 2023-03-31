local event = require('vim_event')

---@type LazyPluginSpec
local indent_blankline = {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    local link_to_non_text = { link = 'NonText' }
    vim.api.nvim_set_hl(0, 'IndentBlanklineChar', link_to_non_text)
    vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#dcdcaa' })
    vim.api.nvim_set_hl(0, 'IndentBlanklineSpaceChar', link_to_non_text)
    require('indent_blankline').setup({
      show_current_context = true
    })
  end,
  dependencies = { require('plugins.treesitter') },
  event = {
    event.buf_new_file,
    event.buf_read_pre
  }
}

return indent_blankline
