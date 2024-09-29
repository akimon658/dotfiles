---@type LazyPluginSpec
return {
  "ryota2357/vim-skim-synctex",
  config = function()
    vim.fn["synctex#option"]("autoActive", true)
    -- vim.fn["synctex#option"]("autoQuit", true)
    vim.fn["synctex#option"]("readingBar", true)
    vim.fn["synctex#start"]()

    -- Not working
    --[[
    require "vim_util".create_autocmd {
      event = require "vim_event".vim_leave_pre,
      config = {
        group = vim.api.nvim_create_augroup("synctex_stop", {}),
        callback = function()
          vim.fn["synctex#stop"]()
        end,
        pattern = "*",
      },
    }
    ]] --
  end,
  dependencies = {
    require "plugins.denops",
  },
  ft = "tex",
  keys = { {
    "<leader>s",
    function()
      vim.fn["synctex#forwardSerch"]()
    end,
  } },
}
