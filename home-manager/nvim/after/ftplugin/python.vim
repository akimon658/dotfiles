augroup auto_format
  autocmd!
  autocmd BufWritePre *.py call FormatOnSave("%!yapf --style google")
augroup END
