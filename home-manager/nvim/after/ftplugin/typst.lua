vim.opt_local.wrap = true

require "nvim-autopairs".add_rule(
  require "nvim-autopairs.rule" ("$", "$", "typst"):with_move(function() return true end)
)
