"  === CONFIGURATION =========================================
set rnu
set number
set path+=**
set wildmode=longest,list,full
set cursorline
set showmatch
set linebreak
set laststatus=2
set tabstop=3
set shiftwidth=3
set softtabstop=3
set noet sts=0 sw=4 ts=4
set cindent
set cinoptions=(0,u0,U0
set spelllang=en_us
set ruler
set autoindent
set mouse=a
set clipboard=unnamed
set incsearch
set hlsearch
set title
filetype plugin indent on
syntax on
set wrap
set nocompatible
set encoding=utf-8
set fillchars+=eob:\
set fillchars+=vert:\  
set t_Co=256


"=== BASIC STYLING ==========================================
highlight Comment cterm=italic
highlight Cursorline ctermbg=Black cterm=bold
highlight CursorlineNr ctermbg=Black cterm=bold ctermfg=Red
highlight LineNr ctermbg=Black ctermfg=Grey
highlight SpellBad ctermbg=Red ctermfg=White
highlight SpellCap cterm=NONE ctermbg=NONE
highlight SpellRare cterm=NONE ctermbg=NONE
highlight SpellLocal cterm=Underline ctermbg=NONE
highlight VertSplit ctermbg=Grey ctermfg=Grey


"=== PLUGins ================================================

call plug#begin()
"00.does the plugin installation

Plug 'tpope/vim-sensible' "requirement from benwainwright/fzf-project
Plug 'junegunn/fzf.vim'   "requirement from benwainwright/fzf-project

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

"01. fzf-project


"02.vifm integration into vim
Plug 'vifm/vifm.vim'

"03. preview substitution changes
Plug 'markonm/traces.vim'

"04. vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Initialize plugin system
call plug#end()

" Call the .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
	source ~/.vimrc.plug
endif

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:skip_defaults_vim = 1

"=== Maps ======================================================

:map <F5> :ls<CR>:e #

let mapleader = " "
nnoremap <leader>F :Files<CR>

"=== Maps for Quickfix  ========================================================

nnoremap <C-k> :cnext<CR>
nnoremap <C-j> :cprev<CR>
