filetype on

function! FormatOnSave(formatCommand)
	let cursor = winsaveview()
	silent! execute a:formatCommand
	call winrestview(cursor)
endfunction

inoremap ( ()<LEFT>
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>

function! NewlineInBrackets()
	let open = getline(".")[col(".")-2]
	let close = getline(".")[col(".")-1]

	let key = "\<CR>"

	if (open == "{" && close == "}") || (open == "(" && close == ")") || (open == "[" && close == "]")
		let key .= "\<ESC>\<S-o>"
	endif

	return key
endfunction
inoremap <silent> <expr> <CR> NewlineInBrackets()

let g:scrollview_column = 1

lua require('config')

nnoremap d "_d

set clipboard+=unnamedplus
set lcs=eol:↲,tab:>_,trail:･
set list
set relativenumber
set shiftwidth=4
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

vnoremap d "_d
