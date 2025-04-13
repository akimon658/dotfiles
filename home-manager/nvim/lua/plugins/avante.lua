---@type LazyPluginSpec
return {
  "yetone/avante.nvim",
  build = "make",
  cmd = {
    "AvanteAsk",
    "AvanteBuild",
    "AvanteChat",
    "AvanteClear",
    "AvanteEdit",
    "AvanteFocus",
    "AvanteHistory",
    "AvanteModels",
    "AvanteRefresh",
    "AvanteStop",
    "AvanteSwitchFileSelectorProvider",
    "AvanteSwitchProvider",
    "AvanteShowRepoMap",
    "AvanteToggle",
  },
  dependencies = {
    require "plugins.copilot",
    require "plugins.devicons",
    require "plugins.nui",
    require "plugins.plenary",
    require "plugins.telescope",
    require "plugins.treesitter",
  },
  opts = {
    provider = "copilot",
  },
  version = false,
}
