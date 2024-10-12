---@type LazyPluginSpec
local vscode_plugin = {
  "Mofiqul/vscode.nvim",
  config = function()
    local vscode = require "vscode"
    local is_wezterm = os.getenv "TERM_PROGRAM" == "WezTerm"
    vscode.setup { transparent = is_wezterm }
    vscode.load()
  end,
}

return vscode_plugin
