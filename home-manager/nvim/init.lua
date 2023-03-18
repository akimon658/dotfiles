local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local builtin = 'telescope.builtin'

local buf_new_file = 'BufNewFile'
local buf_read_pre = 'BufReadPre'
local insert_enter = 'InsertEnter'

-- Type definitions from https://github.com/folke/lazy.nvim/blob/main/lua/lazy/types.lua

---@class lazyPlugin
---@field [1] string
---@field build function
---@field config function|true
---@field dependencies lazySpec[]
---@field event string|string[]
---@field keys keymap[]

---@class keymap
---@field [1] string
---@field [2] function

---@alias lazySpec string|lazyPlugin

local devicons = 'nvim-tree/nvim-web-devicons'
local plenary = 'nvim-lua/plenary.nvim'
---@type lazyPlugin
local lspconfig = {
  'neovim/nvim-lspconfig',
  config = function()
    local lsp_config = require('lspconfig')

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    ---@type boolean
    local use_deno = vim.fn.filereadable(vim.fn.getcwd() .. '/deno.json') == 1
    ---@type string
    local tsserver = use_deno and 'denols' or 'tsserver'

    ---@type string[]
    local servers = {
      'bashls',
      'clangd',
      'cssls',
      'gopls',
      'jsonls',
      'pylsp',
      'sumneko_lua',
      tsserver
    }

    for _, lsp in ipairs(servers) do
      lsp_config[lsp].setup({ capabilities = capabilities })
    end

    lsp_config.powershell_es.setup({
      bundle_path = 'C:/PowerShellEditorServices',
      capabilities = capabilities
    })
  end,
  dependencies = { 'hrsh7th/cmp-nvim-lsp' },
  event = {
    buf_new_file,
    buf_read_pre
  }
}
---@type lazyPlugin
local treesitter = {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  config = function()
    require('nvim-treesitter.configs').setup {
      auto_install = true,
      highlight = {
        enable = true
      }
    }

    require('nvim-treesitter.install').prefer_git = false
  end,
  event = buf_read_pre
}

---@type lazySpec[]
local plugins = {
  {
    'dstein64/nvim-scrollview',
    config = function()
      vim.api.nvim_set_hl(0, 'ScrollView', { link = 'TermCursor' })
      vim.g.scrollview_column = 1
    end,
    event = {
      buf_new_file,
      buf_read_pre
    }
  },
  {
    'folke/trouble.nvim',
    dependencies = { devicons },
    keys = { {
      '<leader>m',
      function()
        require('trouble').toggle()
      end
    } }
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      ---@return boolean
      local function has_words_before()
        local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      cmp.setup {
        formatting = { format = require('lspkind').cmp_format() },
        mapping = {
          ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<Tab>'] = cmp.mapping.confirm {
            select = true
          }
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        sources = {
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' }
        }
      }
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lua',
      {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = { lspconfig }
      },
      'onsails/lspkind.nvim',
      {
        'saadparwaiz1/cmp_luasnip',
        dependencies = { 'L3MON4D3/LuaSnip' }
      },
    },
    event = insert_enter
  },
  {
    'jghauser/mkdir.nvim',
    event = buf_new_file
  },
  {
    'kdheepak/lazygit.nvim',
    config = function()
      vim.g.lazygit_floating_window_use_plenary = 1
    end,
    dependencies = { plenary },
    keys = { {
      '<C-g>',
      function()
        require('lazygit').lazygit()
      end
    } }
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      local character = '┃'
      local link_to_non_text = { link = 'NonText' }
      vim.api.nvim_set_hl(0, 'IndentBlanklineChar', link_to_non_text)
      vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#dcdcaa' })
      vim.api.nvim_set_hl(0, 'IndentBlanklineSpaceChar', link_to_non_text)
      require('indent_blankline').setup({
        char = character,
        context_char = character,
        show_current_context = true
      })
    end,
    dependencies = { treesitter },
    event = {
      buf_new_file,
      buf_read_pre
    }
  },
  {
    'Mofiqul/vscode.nvim',
    config = function()
      local vscode = require('vscode')
      vscode.setup({ transparent = true })
      vscode.load()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    config = true,
    dependencies = { devicons }
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      require('neo-tree').setup({
        close_if_last_window = true,
        filesystem = {
          filtered_items = { visible = true },
          follow_current_file = true,
          use_libuv_file_watcher = true
        },
        view = { relativenumber = true },
        window = { width = 30 }
      })
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      devicons,
      plenary
    },
    keys = { {
      '<C-e>',
      function()
        require('neo-tree.command')._command('toggle')
      end
    } }
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      devicons,
      plenary,
      treesitter
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
      }
    }
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        map_c_h = true
      })
    end,
    event = {
      'BufReadPost',
      buf_new_file
    }
  },
  lspconfig,
  treesitter
}

local opts = {
  checker = { enabled = true },
  defaults = {
    version = '*'
  }
}

require('lazy').setup(plugins, opts)

---@class autoCmdConfig
---@field group any
---@field pattern string[]
---@field callback function

---@class autoCmd
---@field event string
---@field config autoCmdConfig

---@type autoCmd[]
local autocmds = {
  {
    event = 'BufWritePre',
    config = {
      group = vim.api.nvim_create_augroup('fmt', {}),
      callback = vim.lsp.buf.formatting_sync
    }
  },
  {
    event = 'CursorHold',
    config = {
      group = vim.api.nvim_create_augroup('diagnostics_hover', {}),
      callback = function()
        vim.diagnostic.open_float({ focusable = false })
      end
    }
  },
  {
    event = 'InsertLeave',
    config = {
      group = vim.api.nvim_create_augroup('disable_ime', {}),
      callback = function()
        vim.fn.system('zenhan.exe', '0')
      end
    }
  }
}

for _, autocmd in ipairs(autocmds) do
  if autocmd.config.pattern == nil then
    autocmd.config.pattern = { '*' }
  end
  vim.api.nvim_create_autocmd(autocmd.event, autocmd.config)
end

vim.diagnostic.config({ virtual_text = false })

---@class sign
---@field msg_type string
---@field icon string

---@type sign[]
local signs = {
  {
    msg_type = 'Error',
    icon = ''
  },
  {
    msg_type = 'Warn',
    icon = ''
  },
  {
    msg_type = 'Hint',
    icon = ''
  },
  {
    msg_type = 'Info',
    icon = ''
  }
}

for _, sign in ipairs(signs) do
  local hl = 'DiagnosticSign' .. sign.msg_type
  vim.fn.sign_define(hl, {
    text = sign.icon,
    numhl = hl,
    texthl = hl
  })
end

vim.opt.cmdheight = 0
vim.opt.expandtab = true
vim.opt.fileformats = { 'unix', 'dos' }
vim.opt.list = true
vim.opt.listchars = {
  eol = '↲',
  space = '･',
  tab = '  '
}
vim.opt.number = true
vim.opt.updatetime = 1000
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.wrap = false

if vim.fn.has('win64') == 1 then
  vim.opt.shell = 'pwsh -NoLogo'
  vim.opt.shellcmdflag = '-Command'
  vim.opt.shellxquote = ''
end
