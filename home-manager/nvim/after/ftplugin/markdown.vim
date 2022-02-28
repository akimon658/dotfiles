let s:mappings_insert = execute('imap')
if (stridx(s:mappings_insert, "''<Left>") != -1)
	inoremap <buffer> ' '
endif

inoremap <buffer> < <><Left>

setlocal spell
setlocal spelllang=en_us,cjk
setlocal wrap
