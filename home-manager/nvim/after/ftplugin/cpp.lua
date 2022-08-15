local id = vim.api.nvim_create_augroup('cpp_fmt', {})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = id,
  pattern = {'*.cpp'},
  command = 'call FormatOnSave("%!clang-format")'
})
