function! NumberToggle()
	if(&relativenumber == 1)
		set number
	else
		set relativenumber
	endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" virtual tabstops using spaces
let my_tab=4
execute "set shiftwidth=".my_tab
execute "set softtabstop=".my_tab
set expandtab

" allow toggling between local and default mode
function! TabToggle()
	if &expandtab
		set shiftwidth=8
		set softtabstop=0
		set noexpandtab
	else
		execute "set shiftwidth=".g:my_tab
		execute "set softtabstop=".g:my_tab
		set expandtab
	endif
endfunction

nmap <F9> mz:execute TabToggle()<CR>'z

" load pathogen
execute pathogen#infect()

" various settings
syntax enable
set dir=~/.vim/swap/
set nofoldenable
set ruler
set autoindent
set smartindent
set relativenumber
colorscheme Tomorrow-Night
set list
set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&

" Load cf3 plugins
au BufRead,BufNewFile *.cf set ft=cf3
:helptags ~/.vim/doc/
