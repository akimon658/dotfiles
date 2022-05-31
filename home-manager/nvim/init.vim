filetype on

function! FormatOnSave(formatCommand)
	let cursor = winsaveview()
	silent! execute a:formatCommand
	call winrestview(cursor)
endfunction

let g:scrollview_column = 1

lua require('config')

set lcs=eol:↲,tab:>_,trail:･
set list
set showmatch
set splitright

let branch = printf(' (%s)', gitbranch#name())
if (branch == ' ()')
	let branch = ''
endif
let eol = {'dos': 'CRLF', 'unix': 'LF', 'mac': 'CR'}
set statusline=%f%m%{branch}%=%{eol[&fileformat]}

set tabstop=4

tnoremap <silent> <Esc> <C-\><C-n>
