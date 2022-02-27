augroup auto_format
	autocmd!
	autocmd BufWritePre *.py FormatOnSave("%!yapf --style google")
augroup END
