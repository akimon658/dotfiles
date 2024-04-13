vim.g.mapleader = " "

---@type string
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  os.execute("git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

require "lazy".setup("plugins", {
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
})

---@class autoCmdConfig
---@field group any
---@field pattern string[]
---@field callback function

---@class autoCmd
---@field event string
---@field config autoCmdConfig

local any_pattern = { "*" }

---@type autoCmd[]
local autocmds = {
  {
    event = "BufWritePre",
    config = {
      group = vim.api.nvim_create_augroup("fmt", {}),
      callback = function()
        vim.lsp.buf.format {
          filter = function(client)
            return client.server_capabilities.documentFormattingProvider ~= nil
          end,
        }
      end,
      pattern = any_pattern,
    },
  },
  {
    event = "BufWritePre",
    config = {
      group = vim.api.nvim_create_augroup("tex_fmt", {}),
      callback = function()
        local position = vim.fn.getcharpos "."
        ---@type integer
        local line_count = vim.api.nvim_buf_line_count(0)
        ---@type string[]
        local buf_lines = vim.api.nvim_buf_get_lines(0, 0, line_count, true)
        for i, line in ipairs(buf_lines) do
          line = string.gsub(line, "。", "．")
          line = string.gsub(line, "、", "，")
          buf_lines[i] = line
        end
        vim.api.nvim_buf_set_lines(0, 0, line_count, true, buf_lines)
        vim.fn.setcharpos(".", position)
      end,
      pattern = { "*.tex" },
    },
  },
  {
    event = "CursorHold",
    config = {
      group = vim.api.nvim_create_augroup("diagnostics_hover", {}),
      callback = function()
        if not vim.diagnostic.is_disabled() then
          vim.diagnostic.open_float { focusable = false }
        end
      end,
      pattern = any_pattern,
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
  ---@type autoCmd
  local disable_ime = {
    event = "InsertLeave",
    config = {
      group = vim.api.nvim_create_augroup("disable_ime", {}),
      callback = function()
        os.execute(im_disable_cmd)
      end,
      pattern = any_pattern,
    },
  }
  table.insert(autocmds, disable_ime)
end

for _, autocmd in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(autocmd.event, autocmd.config)
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
