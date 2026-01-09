---@type LazyPluginSpec
local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = function()
    require "nvim-treesitter.install".update { with_sync = true }
  end,
  config = function()
    vim.api.nvim_create_autocmd(require "vim_event".file_type, {
      pattern = {
        "gitcommit",
        "nix",
        "python",
        "rust",
        "typescript",
        "sql",
        "typescriptreact",
        "yaml",
      },
      callback = function()
        vim.treesitter.start()

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
  event = require "vim_event".buf_read_pre,
}

return treesitter
