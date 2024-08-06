---@type LazyPluginSpec
local neo_tree = {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    require "plugins_not_vscode.devicons",
    require "plugins_not_vscode.nui",
    require "plugins.plenary",
  },
  keys = { {
    "<C-e>",
    function()
      require "neo-tree.command"._command "toggle"
    end,
  } },
  opts = {
    close_if_last_window = true,
    default_component_configs = {
      git_status = {
        symbols = {
          deleted = "",
        },
      },
    },
    filesystem = {
      filtered_items = { visible = true },
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    view = { relativenumber = true },
    window = { width = 30 },
  },
}

return neo_tree
