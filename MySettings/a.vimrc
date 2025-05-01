" {{{  === Plugins      ===========================================     
	call plug#begin('~/.vim/plugged')

	     Plug 'justinmk/vim-dirvish'	"navigate to folders
	     Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}	"edit in dirvish; not working now
	     Plug 'vim-airline/vim-airline'	"info bar
	     Plug 'vim-airline/vim-airline-themes'	
	     Plug 'airblade/vim-gitgutter'	"Shows chamges I made
	     Plug 'junegunn/goyo.vim'	"writing theme with markdown
	     Plug 'vim-scripts/VisIncr' "increments columns
	     Plug 'voldikss/vim-floaterm' "create floating terminal in center
	     Plug 'dhruvasagar/vim-table-mode'	"create & edit tables
	     Plug 'stevearc/oil.nvim'	"Neovim file explorer: edit your filesystem like a buffer
	     Plug 'jremmen/vim-ripgrep' "Recursive serach in vim
	     Plug 'haya14busa/incsearch.vim' "Highlight all pattern searches
	     Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	     Plug 'junegunn/fzf.vim'	"find words with document preview
	     Plug 'vim-scripts/MultipleSearch2.vim'	"multiple words, different colors highlight 


	call plug#end()
" }}}

" {{{  === Settings     ===========================================     
	set nu
	set rnu
	set lbr
	set wildmenu
	set mouse=a
	set incsearch
	set hlsearch
	set cursorline
	set nocompatible
	set showcmd
	filetype plugin on
	syntax on
	set path+=**
	set cmdheight=1
" }}}

" {{{  === Folds        ===========================================     
set foldmethod=marker
set foldtext=getline(v:foldstart)
" }}}

" {{{  === Themes       ===========================================     
	colorscheme desert
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_theme='raven'  "onedark, raven, term
" }}}

" {{{  === Maps         ===========================================     
	let mapleader = " "

	map <C-j> :cn<CR>
	map <C-k> :cp<CR>
	map <F5> :ls<CR>:e #
	nnoremap <leader>F :Files<CR>
	nnoremap <leader>s :Search 
	
	nnoremap <leader>c :colorscheme<TAB>
	nnoremap <leader>a :AirlineTheme<TAB>
	nnoremap <leader>- :Dirvish<CR>
	nnoremap <leader>T :tabedit<CR>

	noremap <leader>t :bel vert term<CR>	"open vsplit terminal in vim
	
	"Floaterm
	nmap <leader>n :FloatermNew<CR>		"open new floating terminal
	tnoremap <leader>H <C-\><C-n>:FloatermToggle<CR>	"hide floating terminal
	tnoremap <leader>O <C-\><C-n>:FloatermToggle<CR>:FloatermNext<CR>	"from open terminal go to next opened terminal
	nnoremap <leader>S :FloatermShow<CR>	"Show floating terminal
	nnoremap <leader>N :FloatermNext<CR>	"From vim show next opened terminal

	"Moving
	tnoremap <leader>h <c-w>h
	tnoremap <leader>j <c-w>j
	tnoremap <leader>k <c-w>k
	tnoremap <leader>l <c-w>l
	nnoremap <leader>h <c-w>h
	nnoremap <leader>j <c-w>j
	nnoremap <leader>k <c-w>k
	nnoremap <leader>l <c-w>l


" }}}

" {{{ === BASIC STYLING 
"=== BASIC STYLING ========================================
highlight Comment cterm=italic
highlight Cursorline ctermbg=Black cterm=bold ctermfg=White
highlight CursorlineNr ctermbg=Black cterm=bold ctermfg=Red
highlight LineNr ctermbg=Black ctermfg=Grey
highlight Normal ctermfg=Grey  " Set normal text color to grey
highlight SpellBad ctermbg=Red ctermfg=White
highlight SpellCap cterm=NONE ctermbg=NONE
highlight SpellRare cterm=NONE ctermbg=NONE
highlight SpellLocal cterm=Underline ctermbg=NONE
highlight VertSplit ctermbg=Grey ctermfg=Grey
" }}}

" {{{ === Netrw 
"=== Netrw ================================================
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

nnoremap n nzz
nnoremap N Nzz
" }}}
