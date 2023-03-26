---@type LazyPluginSpec
local vscode_plugin = {
  'Mofiqul/vscode.nvim',
  config = function()
    local vscode = require('vscode')
    vscode.setup({ transparent = true })
    vscode.load()
  end
}

return vscode_plugin
