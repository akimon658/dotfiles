local util = require "vim_util"
local event = require "vim_event"
local pattern_tex = "*.tex"

---@type autoCmd[]
local autocmds = {
  {
    event = event.buf_write_pre,
    config = {
      group = util.create_augroup "tex_fmt",
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
      pattern = pattern_tex,
    },
  },
  {
    event = "BufWritePost",
    config = {
      group = util.create_augroup "tex_clean",
      callback = function()
        local fls_files = vim.fn.glob("*.fls", false, true)
        for _, fls_file in ipairs(fls_files) do
          vim.fn.delete(fls_file)
        end
      end,
      pattern = pattern_tex,
    },
  },
}

for _, autocmd in ipairs(autocmds) do
  util.create_autocmd(autocmd)
end
