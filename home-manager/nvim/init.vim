colorscheme slate

filetype on
filetype plugin indent on

function! FormatOnSave(formatCommand)
	let cursor = winsaveview()
	silent! execute a:formatCommand
	call winrestview(cursor)
endfunction

highlight Comment ctermfg=244
highlight LineNr ctermfg=240
highlight LspErrorVirtualText ctermbg=9
highlight ModeMsg ctermfg=248
highlight Nontext ctermfg=240
highlight Pmenu ctermbg=236 ctermfg=248
highlight PmenuSel ctermbg=240 ctermfg=255
highlight SpecialKey ctermfg=240
highlight StatusLine cterm=NONE ctermbg=12 ctermfg=252
highlight TabLine cterm=NONE ctermbg=238 ctermfg=248
highlight TabLineFill cterm=NONE ctermbg=238
highlight Underlined ctermfg=6

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

nnoremap d "_d

set autoindent
set clipboard+=unnamedplus
set lcs=eol:↲,tab:>_,trail:･
set list
set number
set shiftwidth=4
set showmatch
set splitright

let eol = {'dos': 'CRLF', 'unix': 'LF', 'mac': 'CR'}
set statusline=%f%m%=%{eol[&fileformat]}

set tabstop=4

syntax on

tnoremap <silent> <Esc> <C-\><C-n>

vnoremap d "_d
