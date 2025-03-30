local builtin = "telescope.builtin"

---@type LazyPluginSpec
local telescope = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  config = function()
    local args = require "telescope.config".values.vimgrep_arguments
    local additions = {
      "--hidden",
      "--glob",
      "!**/.git/*",
    }
    for _, v in ipairs(additions) do
      table.insert(args, v)
    end

    local telescope = require "telescope"

    telescope.setup {
      defaults = {
        layout_config = {
          prompt_position = "top",
        },
        mappings = {
          i = {
            ["<esc>"] = require "telescope.actions".close,
          },
        },
        prompt_prefix = "  ",
        sorting_strategy = "ascending",
        vimgrep_arguments = args,
      },
      extensions = {
        ["ui-select"] = {
          require "telescope.themes".get_dropdown {},
        },
      },
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob",
            "!**/.git/*",
          },
        },
      },
    }
    telescope.load_extension "ui-select"
  end,
  dependencies = {
    require "plugins.devicons",
    require "plugins.plenary",
    require "plugins.treesitter",
  },
  keys = {
    {
      "<C-f>",
      function()
        require(builtin).current_buffer_fuzzy_find()
      end,
    },
    {
      "<C-p>",
      function()
        require(builtin).find_files()
      end,
    },
    {
      "<leader>f",
      function()
        require(builtin).live_grep()
      end,
    },
    {
      "<leader>rf",
      function()
        require(builtin).lsp_references()
      end,
    },
    {
      "<leader>?",
      function()
        require(builtin).help_tags()
      end,
    },
  },
}

return telescope
