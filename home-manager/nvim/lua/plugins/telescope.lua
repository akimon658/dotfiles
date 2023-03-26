local builtin = 'telescope.builtin'

---@type LazyPluginSpec
local telescope = {
  'nvim-telescope/telescope.nvim',
  config = function()
    local args = require('telescope.config').values.vimgrep_arguments
    local additions = {
      '--hidden',
      '--glob',
      '!**/.git/*'
    }
    for _, v in ipairs(additions) do
      table.insert(args, v)
    end

    require('telescope').setup({
      defaults = {
        layout_config = {
          prompt_position = 'top',
        },
        mappings = {
          i = {
            ['<esc>'] = require('telescope.actions').close
          }
        },
        prompt_prefix = '  ',
        sorting_strategy = 'ascending',
        vimgrep_arguments = args
      },
      pickers = {
        find_files = {
          find_command = {
            'rg',
            '--files',
            '--hidden',
            '--glob',
            '!**/.git/*'
          }
        }
      }
    })
  end,
  dependencies = {
    require('plugins.devicons'),
    require('plugins.plenary'),
    require('plugins.treesitter')
  },
  keys = {
    {
      '<C-f>',
      function()
        require(builtin).current_buffer_fuzzy_find()
      end
    },
    {
      '<C-p>',
      function()
        require(builtin).find_files()
      end
    },
    {
      '<leader>?',
      function()
        require(builtin).help_tags()
      end
    }
  }
}

return telescope
