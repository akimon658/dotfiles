let s:mappings_insert = execute('imap')
if (stridx(s:mappings_insert, "''<Left>") != -1)
	inoremap <buffer> ' '
endif

setlocal wrap
