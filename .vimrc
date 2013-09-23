function! NumberToggle()
	if(&relativenumber == 1)
		set number
	else
		set relativenumber
	endif
endfunc

execute pathogen#infect()

set dir=~/.vim/swap/
set nofoldenable
set ruler
set autoindent
set smartindent
set relativenumber
colorscheme Tomorrow-Night
set list
set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&

nnoremap <C-n> :call NumberToggle()<cr>

au BufRead,BufNewFile *.cf set ft=cf3
:helptags ~/.vim/doc/
