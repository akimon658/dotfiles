---@type LazyPluginSpec
local neogit = {
  'TimUntersberger/neogit',
  config = function()
    require('neogit').setup({
      disable_commit_confirmation = true
    })
  end,
  dependencies = { require('plugins.plenary') },
  keys = { {
    '<C-g>',
    function()
      require('neogit').open()
    end
  } }
}

return neogit
