---@type LazyPluginSpec
return {
  "TaDaa/vimade",
  event = require "vim_event".very_lazy,
  opts = {
    recipe = {
      "default",
      {
        animate = true,
      },
    },
  },
}
