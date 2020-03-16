" #######################################################
" ---------------------- PLUGINS ------------------------
" #######################################################
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'crusoexia/vim-monokai'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'brennier/quicktex'
Plug 'lervag/vim-foam'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'nvie/vim-flake8'
Plug 'svermeulen/vim-subversive' " adds substitute commmmands to paste over a text object (ie. `siw`)
Plug 'chrisbra/improvedft' "allows f, t, F, and T to be used over multiple lines
Plug 'chrisbra/Colorizer' "Highlights hex values in their respective color
Plug 'Yggdroot/indentLine' " add pipe line stuff
Plug 'adelarsq/vim-matchit' " for '%' to go between do/endo and if/else/elseif/endif statements
Plug 'sheerun/vim-polyglot' " lots of language syntax support
Plug 'crusoexia/vim-monokai' " for monokai color scheme
Plug 'editorconfig/editorconfig-vim' " for using .editorconfig files
Plug 'junegunn/gv.vim' " For browsing git commit history (requires fugitive)
Plug 'tpope/vim-git' " plugin/syntax stuff for git files (commit, rebase -i, etc)

let intellisense_plugin = "ncm2"

if intellisense_plugin=="ncm2"
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'

    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

    " IMPORTANTE: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect

    " NOTE: you need to install completion sources to get completions. Check
    " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-tmux'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-jedi'

    " custom key mapping for manual trigger
    inoremap <C-space> <C-r>=ncm2#force_trigger()<cr>
endif

call plug#end()

" #######################################################
" ----------------- GENERAL SETTINGS --------------------
" #######################################################
set number relativenumber " hybrid relative line numbers
set termguicolors     " Done due to MobaXterm not displaying cursor
" correctly

set showmatch           " Show matching brakets.
set formatoptions+=o    " Continue comment marker in new line
set expandtab           " Insert spaces when <TAB> is pressed
set tabstop=4           " Set number of spaces inserted when <TAB> is pressed
set shiftwidth=4        " Indentation amount when using << and >>
set shiftround          " Makes the shift command move in multiples of shiftwidth

set splitbelow          " Horizontal split below current
set splitright          " Vetical split to right of current

set ignorecase          " Make searching case insensitive...
set smartcase           " ... unless the query has a capital letter in it
" set gdefault            " Use 'g' flag by default for :s/foo/bar/

set scrolloff=2         " Forces a minimum number of lines above and below cursor

set cursorline          " Highlights the current line of the cursor

syntax on

colorscheme monokai

" Make background opacity terminal emulator dependent
" !! Must be after colorsceme setting
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none

" #######################################################
" ------------------ PLUGIN SETTINGS --------------------
" #######################################################

" Airline------------------
let g:airline_powerline_fonts=1
let g:airline_theme='molokai'

let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10

" NERDTree------------------
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" ctrlp-----------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1

set wildignore+=*/.git/*,*/.hg/*,*/.svn/* " Ignore source control folders

" QuickTeX---------------------
let g:quicktex_tex = {
            \' '   : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
            \'m'   : '\( <+++> \) <++>',
            \'prf' : "\\begin{proof}\<CR><+++>\<CR>\\end{proof}",
            \}

let g:quicktex_math = {
            \' '    : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
            \'fr'   : '\mathcal{R} ',
            \'eq'   : '= ',
            \'set'  : '\{ <+++> \} <++>',
            \'frac' : '\frac{<+++>}{<++>} <++>',
            \'one'  : '1 ',
            \'st'   : ': ',
            \'in'   : '\in ',
            \'bn'   : '\mathbb{N} ',
            \}


" subversive----------------------------
" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" For doing fancy substitutions without using `:s/foo/bar/gc`
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

" same as fancy substitutions, but with confirmation at each substitute
nmap <leader>cr <plug>(SubversiveSubstituteRangeConfirm)
xmap <leader>cr <plug>(SubversiveSubstituteRangeConfirm)
nmap <leader>crr <plug>(SubversiveSubstituteWordRangeConfirm)

" #######################################################
" ---------------------- REMAPS -------------------------
" #######################################################

" Makes the <++> tag work
" inoremap <Space><Space> <Esc>/<++><Enter>"_c4l

" Remaps for Tabs
nnoremap tn :tabnew<Space>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tj :tabfirst<CR>
nnoremap tk :tablast<CR>

" Remap for Tab to window switch
nnoremap <Tab> <C-W>W
nnoremap <S-Tab> <C-W>w

" Terminal Mode exit
tnoremap <Esc> <C-\><C-n>

" #######################################################
" --------------- COMMANDS & FUNCTIONS ------------------
" #######################################################

function! Toggle_SignColumn()
    if &signcolumn == 'yes'
        let &signcolumn='no'
    else
        let &signcolumn='yes'
    endif
endfunction

" Command to toggle line numbers for copying
:command! Copymode set number! rnu! | call Toggle_SignColumn() | :IndentLinesToggle
:command! Chars :w !wc -m

" #######################################################
" --------------- FILE TYPE OVERRIDES -------------------
" #######################################################

autocmd FileType c call SetCOptions()
autocmd FileType fortran call SetFortranOptions()
autocmd FileType xdefaults call SetXdefaultsOptions()
autocmd FileType text,markdown setlocal spell
autocmd FileType markdown call SetMarkdownOptions()


function SetCOptions()
    setlocal expandtab
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal commentstring=//\ %s
endfunction

function SetFortranOptions()
    setlocal expandtab
    setlocal tabstop=2
    setlocal shiftwidth=2
    :syn clear fortranSerialNumber
endfunction

function SetXdefaultsOptions()
    setlocal commentstring=!\ %s
endfunction

function SetMarkdownOptions()
    let b:indentLine_enabled = 0
endfunction
