set relativenumber
set termguicolors

set showmatch           " Show matching brakets.
set formatoptions+=o	" Continue comment marker in new line
set expandtab           " Insert spaces when <TAB> is pressed
set tabstop=4           " Set number of spaces inserted when <TAB> is pressed
set shiftwidth=4        " Indentation amount when using << and >>

set splitbelow          " Horizontal split below current
set splitright          " Vetical split to right of current

set ignorecase          " Make searching case insensitive...
set smartcase           " ... unless the query has a capital letter in it
set gdefault            " Use 'g' flag by default for :s/foo/bar/

syntax on
colorscheme monokai

" Plugins---------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'crusoexia/vim-monokai'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

call plug#end()

" Plugin Settings--------------

" Airline
let g:airline_powerline_fonts=1
let g:airline_theme='molokai'

let g:airline#extensions#whitespace#enabled = 1

" NERDTree------------------
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

