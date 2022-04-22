augroup go_format
	autocmd!
	autocmd BufWritePre *.go call FormatOnSave("%!gofmt -s")
augroup END

let b:AutoPairs = AutoPairsDefine({}, ["'"])

packadd vim-goimports
