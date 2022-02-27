augroup auto_format
	autocmd!
	autocmd BufWritePre *.py silent! execute "%!yapf --style google"
augroup END
