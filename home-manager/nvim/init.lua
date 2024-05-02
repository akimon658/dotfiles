vim.g.mapleader = " "

---@type string
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  os.execute("git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

require "lazy".setup {
  checker = { enabled = true },
  defaults = {
    version = "*",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  spec = {
    { import = "plugins" },
    {
      import = "plugins_not_vscode",
      cond = not vim.g.vscode,
    },
  },
}

local uname = vim.loop.os_uname()
---@type string
local sysname = uname.sysname
local is_windows = sysname == "Windows_NT"
local is_wsl = sysname == "Linux" and string.find(uname.release, "microsoft") ~= nil
local is_mac = sysname == "Darwin"
local im_disable_cmd = ""

if is_windows or is_wsl then
  im_disable_cmd = "zenhan.exe 0"
elseif is_mac then
  im_disable_cmd = "osascript -e 'tell application \"System Events\" to key code 102'"
end

if im_disable_cmd ~= "" then
  require "vim_util".create_autocmd {
    event = "InsertLeave",
    config = {
      group = vim.api.nvim_create_augroup("disable_ime", {}),
      callback = function()
        os.execute(im_disable_cmd)
      end,
      pattern = "*",
    },
  }
end

vim.diagnostic.config { virtual_text = false }

---@class sign
---@field msg_type string
---@field icon string

---@type sign[]
local signs = {
  {
    msg_type = "Error",
    icon = "",
  },
  {
    msg_type = "Warn",
    icon = "",
  },
  {
    msg_type = "Hint",
    icon = "",
  },
  {
    msg_type = "Info",
    icon = "",
  },
}

for _, sign in ipairs(signs) do
  local hl = "DiagnosticSign" .. sign.msg_type
  vim.fn.sign_define(hl, {
    text = sign.icon,
    numhl = hl,
    texthl = hl,
  })
end

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.opt.cmdheight = 0
vim.opt.expandtab = true
vim.opt.fileformats = { "unix", "dos" }
vim.opt.list = true
vim.opt.listchars = {
  eol = "↲",
  space = "･",
  tab = "  ",
}
vim.opt.number = true
vim.opt.updatetime = 1000
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.wrap = false

if is_windows then
  vim.opt.shell = "pwsh -NoLogo"
  vim.opt.shellcmdflag = "-Command"
  vim.opt.shellxquote = ""
end
