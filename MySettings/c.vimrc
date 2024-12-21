" === Plugins 
	call plug#begin('~/.vim/plugged')

	     Plug 'justinmk/vim-dirvish'	"navigate to folders
	     Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}	"edit in dirvish; not working now
	     Plug 'vim-airline/vim-airline'	"info bar
	     Plug 'vim-airline/vim-airline-themes'	
	     Plug 'airblade/vim-gitgutter'	"Shows chamges I made
	     Plug 'junegunn/goyo.vim'	"writing theme with markdown
	     Plug 'voldikss/vim-floaterm' "create floating terminal in center
	     

	call plug#end()


" === Settings 
	set nu
	set rnu
	set lbr
	set wildmenu
	set mouse=a
	set incsearch
	set hlsearch
	set cursorline
	set nocompatible
	filetype plugin on
	syntax on
	set path+=**


" === Folds
set foldtext=getline(v:foldstart)
set foldmethod=manual
" Automatically save and load views
augroup view
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent loadview
augroup END


" === Themes 
	colorscheme green
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_theme='apprentice'


" === Maps 
	let mapleader = " "

	map <C-j> :cn<CR>
	map <C-k> :cp<CR>

	nnoremap <leader>c :colorscheme<TAB>
	nnoremap <leader>a :AirlineTheme<TAB>
	nnoremap <leader>- :Dirvish<CR>
	noremap <leader>t :bel vert term<CR>	"open vsplit terminal in vim
	nmap <leader>n :FloatermNew<CR>		"open new floating terminal
	tnoremap <leader>h <C-\><C-n>:FloatermToggle<CR>	"hide floating terminal
	tnoremap <leader>m <C-\><C-n>:FloatermToggle<CR>:FloatermNext<CR>	"from open terminal go to next opened terminal
	nnoremap <leader>H :FloatermShow<CR>	"Show floating terminal
	nnoremap <leader>N :FloatermNext<CR>	"From vim show next opened terminal


