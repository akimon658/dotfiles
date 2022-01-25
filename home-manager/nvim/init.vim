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
	let nlInBrackets = "\<CR>\<ESC>\<S-o>"
	let open = getline(".")[col(".")-2]
	let close = getline(".")[col(".")-1]

	if (open == "{" && close == "}") || (open == "(" && close == ")") || (open == "[" && close == "]")
		return nlInBrackets
	else
		return "\<CR>"
	endif
endfunction
inoremap <silent> <expr> <CR> NewlineInBrackets()

augroup pair
	autocmd!
	autocmd FileType html inoremap < <><LEFT>
	autocmd FileType go inoremap ` ``<LEFT>
	autocmd FileType scss inoremap ' ''<LEFT>
	autocmd FileType typescript inoremap ' ''<LEFT>
augroup END

let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'deno']

autocmd! FileType go packadd vim-goimports

set autoindent
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
