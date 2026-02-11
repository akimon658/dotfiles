vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "asm",
    "gitcommit",
    "markdown",
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
