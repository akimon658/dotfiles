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
    prompt_prefix = "  ",
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
