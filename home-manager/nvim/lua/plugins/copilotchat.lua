---@type LazyPluginSpec
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  build = "make tiktoken",
  cmd = {
    "CopilotChatToggle",
  },
  dependencies = {
    require "plugins.copilot",
    require "plugins.plenary",
  },
  opts = {},
}
