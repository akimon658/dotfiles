---@type LazyPluginSpec
local lualine = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    require "plugins_not_vscode.devicons",
    require "plugins_not_vscode.vscode",
    {
      "AndreM222/copilot-lualine",
      dependencies = { require "plugins_not_vscode.copilot" },
    },
  },
  opts = {
    options = {
      globalstatus = true,
    },
    sections = {
      lualine_x = {
        {
          "copilot",
          show_colors = true
        },
        "encoding",
        "fileformat",
        "filetype",
      },
    },
  },
}

return lualine
