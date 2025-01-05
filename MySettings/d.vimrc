" {{{ === CONFIGURATION 
"=== CONFIGURATION ========================================
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
" }}}

" {{{ === BASIC STYLING 
"=== BASIC STYLING ========================================
highlight Comment cterm=italic
highlight Cursorline ctermbg=Black cterm=bold
highlight CursorlineNr ctermbg=Black cterm=bold ctermfg=Red
highlight LineNr ctermbg=Black ctermfg=Grey
highlight SpellBad ctermbg=Red ctermfg=White
highlight SpellCap cterm=NONE ctermbg=NONE
highlight SpellRare cterm=NONE ctermbg=NONE
highlight SpellLocal cterm=Underline ctermbg=NONE
highlight VertSplit ctermbg=Grey ctermfg=Grey
" }}}

" {{{ === Maps  
"=== Maps =================================================

:map <F5> :ls<CR>:e #

let mapleader = " "
nnoremap <leader>F :20 Lex<CR>
" }}}

" {{{ === Maps for Quickfix 
"=== Maps for Quickfix ====================================

nnoremap <C-k> :cnext<CR>
nnoremap <C-j> :cprev<CR>
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

" {{{ ===       
"===  Folds     ================================================
set foldmethod=marker
set foldtext=getline(v:foldstart)
" }}}

