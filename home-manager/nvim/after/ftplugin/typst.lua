vim.opt_local.wrap = true

require "nvim-autopairs".add_rule(
  require "nvim-autopairs.rule" ("$", "$", "typst"):with_move(function() return true end)
)

local util = require "vim_util"

util.create_autocmd {
  event = require "vim_event".buf_write_pre,
  config = {
    group = util.create_augroup "typst_fmt",
    callback = function()
      vim.cmd ":silent! %s/。/．/g"
      vim.cmd ":silent! %s/、/，/g"
    end,
    pattern = "*.typ",
  },
}
