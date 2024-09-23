---@type LazyPluginSpec
local vscode_plugin = {
  "Mofiqul/vscode.nvim",
  config = function()
    local vscode = require "vscode"
    local wezterm_pane = os.getenv "WEZTERM_PANE"
    vscode.setup { transparent = wezterm_pane and true or false }
    vscode.load()
  end,
}

return vscode_plugin
