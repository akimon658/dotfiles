if UseDeno then
  local id = vim.api.nvim_create_augroup('ts_fmt', {})

  vim.api.nvim_create_autocmd('BufWritePre', {
    group = id,
    pattern = {'*.ts'},
    command = 'call FormatOnSave("%!deno fmt -")'
  })
end
