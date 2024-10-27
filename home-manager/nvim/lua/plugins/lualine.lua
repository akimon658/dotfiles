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
      lualine_b = {
        "branch",
        {
          function()
            local output = io.popen "git rev-list --left-right --count HEAD...@{upstream}":read()
            local ahead, behind = string.match(output, "(%d+)%s+(%d+)")
            return behind .. " " .. ahead .. ""
          end,
          color = "NonText",
          cond = function()
            return os.execute "git rev-parse --is-inside-work-tree > /dev/null 2>&1" == 0
          end,
        },
        "diff",
        "diagnostics",
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
