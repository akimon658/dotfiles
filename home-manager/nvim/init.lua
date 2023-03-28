vim.g.mapleader = ' '

---@type string
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  os.execute('git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ' .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  checker = { enabled = true },
  defaults = {
    version = '*'
  }
}

require('lazy').setup('plugins', opts)

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
        os.execute('zenhan.exe 0')
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

vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover)

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
