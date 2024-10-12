---@type LazyPluginSpec
local lualine = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    require "plugins.devicons",
    require "plugins.vscode",
    {
      "AndreM222/copilot-lualine",
      dependencies = { require "plugins.copilot" },
    },
  },
  opts = {
    options = {
      globalstatus = true,
      section_separators = "",
    },
    sections = {
      lualine_a = {
        {
          "mode",
          separator = {
            right = "",
          },
        },
      },
      lualine_x = {
        {
          "copilot",
          show_colors = true,
        },
        {
          "encoding",
          fmt = function(str)
            return string.upper(str)
          end,
        },
        "fileformat",
        {
          "filetype",
          fmt = function(str)
            return string.gsub(str, "^%l", string.upper)
          end,
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
  },
}

return lualine
