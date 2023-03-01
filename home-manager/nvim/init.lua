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

local buf_read_pre = 'BufReadPre'
local insert_enter = 'InsertEnter'

local cmp_nvim_lsp = 'hrsh7th/cmp-nvim-lsp'
local devicons = 'nvim-tree/nvim-web-devicons'
local plenary = 'nvim-lua/plenary.nvim'
local treesitter = {
  'nvim-treesitter/nvim-treesitter',
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

-- Type definitions from https://github.com/folke/lazy.nvim/blob/main/lua/lazy/types.lua

---@class lazyPlugin
---@field [1] string
---@field config function|true
---@field dependencies lazySpec[]
---@field event string
---@field keys keymap[]

---@class keymap
---@field [1] string
---@field [2] function

---@alias lazySpec string|lazyPlugin

---@type lazySpec[]
local plugins = {
  {
    'dstein64/nvim-scrollview',
    config = function()
      vim.g.scrollview_character = '▎'
      vim.g.scrollview_column = 1
    end,
    event = buf_read_pre
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
            elseif luasnip.jumpable( -1) then
              luasnip.jump( -1)
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
        'saadparwaiz1/cmp_luasnip',
        dependencies = { 'L3MON4D3/LuaSnip' }
      },
      cmp_nvim_lsp
    },
    event = insert_enter
  },
  {
    'jghauser/mkdir.nvim',
    event = 'BufNewFile'
  },
  {
    'jiangmiao/auto-pairs',
    event = 'BufReadPost'
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
    'Mofiqul/vscode.nvim',
    config = function()
      vim.g.vscode_transparent = 1
      vim.cmd('colorscheme vscode')
    end
  },
  {
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
        lsp_config[lsp].setup {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          }
        }
      end

      lsp_config.powershell_es.setup {
        bundle_path = 'C:/PowerShellEditorServices',
        capabilities = capabilities
      }
    end,
    dependencies = { cmp_nvim_lsp },
    event = buf_read_pre
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
        filesystem = { follow_current_file = true },
        view = { relativenumber = true },
        window = { width = 30 }
      })

      vim.cmd(':Neotree')
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      devicons,
      plenary
    }
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
          require(builtin).live_grep()
        end
      },
      {
        '<C-p>',
        function()
          require(builtin).git_files()
        end
      }
    }
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { treesitter },
    event = buf_read_pre
  },
  treesitter
}

local opts = {
  defaults = {
    version = '*'
  }
}

require('lazy').setup(plugins, opts)

local pattern_any = { '*' }

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
      pattern = pattern_any,
      callback = vim.lsp.buf.formatting_sync
    }
  },
  {
    event = 'InsertLeave',
    config = {
      group = vim.api.nvim_create_augroup('disable_ime', {}),
      pattern = pattern_any,
      callback = function()
        vim.fn.system('zenhan.exe', '0')
      end
    }
  }
}

for _, autocmd in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(autocmd.event, autocmd.config)
end

vim.opt.cmdheight = 0
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = {
  eol = '↲',
  tab = '>_',
  trail = '･'
}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.wrap = false

if vim.fn.has('win64') == 1 then
  vim.opt.shell = 'pwsh -NoLogo'
  vim.opt.shellcmdflag = '-Command'
  vim.opt.shellxquote = ''
end
