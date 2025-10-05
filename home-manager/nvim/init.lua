vim.g.mapleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  os.execute("git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

require "lazy".setup {
  checker = { enabled = true },
  defaults = {
    version = "*",
  },
  spec = { import = "plugins" },
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
}

local uname = vim.uv.os_uname()
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

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
}

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.filetype.add {
  extension = {
    mdx = "markdown.mdx",
  },
  pattern = {
    Caddyfile = "caddy",
    ["openapi.*%.ya?ml"] = "yaml.openapi",
  },
}

vim.lsp.enable {
  "denols",
  "golangci_lint_ls",
  "gopls",
  "jsonls",
  "lua_ls",
  "metals",
  "ts_ls",
}
vim.lsp.inlay_hint.enable()

vim.opt.cmdheight = 0
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { background = "#444444" })
vim.opt.expandtab = true
vim.opt.fileformats = { "unix", "dos" }
vim.opt.fillchars = {
  eob = " ",
}
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = {
  eol = "↲",
  precedes = "<",
  space = "･",
  tab = "> ",
}
vim.opt.number = true
vim.opt.updatetime = 1000
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.winborder = "rounded"
vim.opt.wrap = false

if is_windows then
  vim.opt.shell = "pwsh -NoLogo"
  vim.opt.shellcmdflag = "-Command"
  vim.opt.shellxquote = ""
end
