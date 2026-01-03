---@type LazyPluginSpec
local vscode_plugin = {
  "Mofiqul/vscode.nvim",
  config = function()
    local vscode = require "vscode"
    local is_ghostty = os.getenv "TERM_PROGRAM" == "ghostty"
    vscode.setup { transparent = is_ghostty }
    vscode.load()
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
  end,
}

return vscode_plugin
