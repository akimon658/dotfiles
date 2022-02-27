augroup go_format
	autocmd!
	autocmd BufWritePre *.go silent! execute "%!gofmt -s"
augroup END

inoremap <buffer> ` ``<LEFT>

let s:mappings_insert = execute('imap')
if (stridx(s:mappings_insert, "''<Left>") != -1)
	inoremap <buffer> ' '
endif

packadd vim-goimports
