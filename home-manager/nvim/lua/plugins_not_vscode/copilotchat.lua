---@type LazyPluginSpec
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  build = "make tiktoken",
  cmd = {
    "CopilotChatToggle",
  },
  dependencies = {
    require "plugins_not_vscode.copilot",
    require "plugins.plenary",
  },
  opts = {},
}
