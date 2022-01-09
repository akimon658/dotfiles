colorscheme slate

filetype on

hi Comment ctermfg=244
hi LineNr ctermfg=240
hi LspErrorVirtualText ctermbg=9
hi ModeMsg ctermfg=248
hi Nontext ctermfg=240
hi Pmenu ctermbg=236 ctermfg=248
hi PmenuSel ctermbg=240 ctermfg=255
hi SpecialKey ctermfg=240
hi StatusLine cterm=NONE ctermbg=12 ctermfg=252
hi TabLine cterm=NONE ctermbg=238 ctermfg=248
hi TabLineFill cterm=NONE ctermbg=238
hi Underlined ctermfg=6

inoremap ( ()<LEFT>
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap " ""<LEFT>

function! NewlineWithIndent()
	let nlAndIndent = "\n\t\n\<UP>\<END>"
	let open = getline(".")[col(".")-2]
	let close = getline(".")[col(".")-1]

	if close == "}" && open == "{"
		return nlAndIndent
	elseif close == ")" && open == "("
		return nlAndIndent
	elseif close == "]" && open == "["
		return nlAndIndent
	else
		return "\n"
	endif
endfunction
inoremap <silent> <expr> <CR> NewlineWithIndent()

augroup pair
	autocmd!
	autocmd FileType !go,!markdown,!text inoremap ' ''<LEFT>
	autocmd FileType html inoremap < <><LEFT>
	autocmd FileType go inoremap ` ``<LEFT>
augroup end

autocmd! FileType go packadd vim-goimports

set autoindent
set lcs=eol:↲,tab:>_,trail:･
set list
set number
set shiftwidth=4
set showmatch
set splitright

let eol = {'dos': 'CRLF', 'unix': 'LF', 'mac': 'CR'}
set statusline=%f%m%=%{eol[&fileformat]}\ [%l\ %c\ %P]

set tabstop=4

autocmd! Filetype json set filetype=jsonc

syntax on

tnoremap <silent> <Esc> <C-\><C-n>
