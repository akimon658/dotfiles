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
    disable_commit_confirmation = true,
  },
}

return neogit
