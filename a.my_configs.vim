set nu
set rnu
set mouse=a
set incsearch
set hlsearch
set cursorline


call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'markonm/traces.vim'
Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

set background=dark
colorscheme palenight
let g:lightline = { 'colorscheme': 'palenight' }
let g:airline_theme = "palenight"


nnoremap <leader>c :Colors<CR>
map <C-j> :cn<CR>
map <C-k> :cp<CR>
