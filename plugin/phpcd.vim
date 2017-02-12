let s:save_cpo = &cpo
set cpo&vim

let g:phpcd_root = '/'
let g:phpcd_php_cli_executable = 'php'

let s:root = phpcd#GetRoot()
if filereadable(s:root.'/.phpcd.vim')
	exec 'source '.s:root.'/.phpcd.vim'
endif

let g:phpcd_need_update = 0
let g:phpcd_jump_stack = []

if !exists('g:phpcd_autoload_path')
	let g:phpcd_autoload_path = 'vendor/autoload.php'
endif

autocmd BufLeave,VimLeave *.php if g:phpcd_need_update > 0 | call phpcd#UpdateIndex() | endif
autocmd BufWritePost *.php let g:phpcd_need_update = 1
autocmd FileType php setlocal omnifunc=phpcd#CompletePHP

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker:noexpandtab:ts=2:sts=2:sw=2
