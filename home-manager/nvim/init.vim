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

augroup pair
	autocmd!
	autocmd FileType go inoremap ` ``<LEFT>
	autocmd FileType python,scss,typescript inoremap ' ''<LEFT>
augroup END

let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'deno']

nnoremap d "_d

augroup plugins
	autocmd!
	autocmd FileType html packadd emmet-vim
	autocmd FileType css,scss packadd vim-css-color
	autocmd FileType go packadd vim-goimports
augroup END

set autoindent
set clipboard+=unnamedplus
set lcs=eol:↲,tab:>_,trail:･
set list
set number

augroup wrapping
	autocmd!
	autocmd FileType typescript set nowrap
augroup END

set shiftwidth=4
set showmatch
set smartindent
set splitright

let eol = {'dos': 'CRLF', 'unix': 'LF', 'mac': 'CR'}
set statusline=%f%m%=%{eol[&fileformat]}\ [%l\ %c\ %P]

set tabstop=4

autocmd! Filetype json set filetype=jsonc

augroup spell_check
	autocmd!
	autocmd FileType markdown,text set spell
	autocmd FileType markdown,text set spelllang=en_us,cjk
augroup END

syntax on

tnoremap <silent> <Esc> <C-\><C-n>
