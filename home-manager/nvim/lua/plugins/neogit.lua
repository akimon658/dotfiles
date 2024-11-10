---@type LazyPluginSpec
local neogit = {
  "NeogitOrg/neogit",
  branch = "master",
  dependencies = { require "plugins.plenary" },
  keys = { {
    "<C-g>",
    function()
      require "neogit".open()
    end,
  } },
  opts = {
    process_spinner = false,
  },
}

return neogit
