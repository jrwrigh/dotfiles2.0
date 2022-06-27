" #######################################################
" ---------------------- PLUGINS ------------------------
" #######################################################

" Avoid matlab/mathematica confusion. See vim-polyglot/#498
let g:polyglot_disabled = ['mathematica']

call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'crusoexia/vim-monokai'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'nvie/vim-flake8'
Plug 'svermeulen/vim-subversive' " adds substitute commmmands to paste over a text object (ie. `siw`)
Plug 'chrisbra/improvedft' "allows f, t, F, and T to be used over multiple lines
Plug 'chrisbra/Colorizer' "Highlights hex values in their respective color
Plug 'Yggdroot/indentLine' " add pipe line stuff
Plug 'adelarsq/vim-matchit' " for '%' to go between do/endo and if/else/elseif/endif statements
Plug 'sheerun/vim-polyglot' " lots of language syntax support
Plug 'editorconfig/editorconfig-vim' " for using .editorconfig files
Plug 'tpope/vim-git' " plugin/syntax stuff for git files (commit, rebase -i, etc)
Plug 'rbong/vim-flog' " for browsing git log branches
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' } " Create docstring using :Pydocstring
Plug '~/.local/src/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
Plug 'lervag/vimtex'

let intellisense_plugin = "coc.nvim"

"" NCM2 Settings
if intellisense_plugin=="ncm2"
    source ~/.config/nvim/ncm2_settings.vim

"" Coc.Nvim Settings
elseif intellisense_plugin=="coc.nvim"
    source ~/.config/nvim/coc_settings.vim
endif

call plug#end()

" #######################################################
" ----------------- GENERAL SETTINGS --------------------
" #######################################################
set number relativenumber " hybrid relative line numbers
set termguicolors     " Done due to MobaXterm not displaying cursor
" correctly

set showmatch        " Show matching brakets.
set formatoptions+=o " Continue comment marker in new line
set expandtab        " Insert spaces when <TAB> is pressed
set tabstop=4        " Set number of spaces inserted when <TAB> is pressed
set shiftwidth=4     " Indentation amount when using << and >>
set shiftround       " Makes the shift command move in multiples of shiftwidth

set splitbelow       " Horizontal split below current
set splitright       " Vetical split to right of current

set ignorecase       " Make searching case insensitive...
set smartcase        " ... unless the query has a capital letter in it

set scrolloff=2      " Forces a minimum number of lines above and below cursor

set cursorline       " Highlights the current line of the cursor
set undofile         " Saves buffer change history after exit

syntax on

colorscheme monokai

" Make background opacity terminal emulator dependent
" !! Must be after colorsceme setting
highlight Normal ctermbg=none guibg=none
highlight NonText ctermbg=none guibg=none
highlight LineNr ctermbg=none guibg=none
highlight clear Conceal

set list
set listchars=tab:⇄\ ,trail:␣,extends:❯,precedes:❮
set showbreak=↳

set diffopt+=algorithm:minimal

let g:tex_conceal='abdmg'

" #######################################################
" ------------------ PLUGIN SETTINGS --------------------
" #######################################################

"" Coc.Nvim-----------------
hi CocUnderline gui=undercurl term=undercurl cterm=undercurl
hi CocErrorHighlight ctermfg=red  guifg=#c4384b gui=undercurl term=undercurl cterm=undercurl
hi CocWarningHighlight ctermfg=yellow guifg=#c4ab39 gui=undercurl term=undercurl cterm=undercurl

"" Spell--------------------
hi SpellBad     gui=undercurl guisp=red term=undercurl cterm=undercurl
hi SpellCap     gui=undercurl guisp=purple term=undercurl cterm=undercurl
hi SpellLocal   gui=undercurl term=undercurl cterm=undercurl
hi SpellRare    gui=undercurl term=undercurl cterm=undercurl

"" Airline------------------
let g:airline_powerline_fonts=1
let g:airline_theme='molokai'

" Change the symbol displayed for modes
let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ '^S'     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ '^V'     : 'V',
    \ }

" Make file line/columns section less verbose
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'maxlinenr', ':%v'])

" Make block format line
let g:airline_left_sep=''
let g:airline_right_sep=''

" Minimalize statusline
let g:airline_symbols.dirty = '*'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10

"" NERDTree------------------
autocmd StdinReadPre * let s:std_in=1

"" ctrlp-----------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1

set wildignore+=*/.git/*,*/.hg/*,*/.svn/* " Ignore source control folders



"" subversive----------------------------
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

"" polyglot
" let YAML and TOML frontmatter be handled
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1

"" pydocstring

let g:pydocstring_formatter = 'numpy'
let g:pydocstring_enable_mapping = 0

"" indentLine
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
let g:indentLine_char = "┊"

"" vim-easy-align
nmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ }


"" fzf-------------------
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fF :Files
nnoremap <leader>fg :GitFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fL :BLines<CR>

"" Vim-tex ---------------
let g:vimtex_view_method = 'zathura'

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

" Navigate splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Terminal Mode exit
tnoremap <Esc> <C-\><C-n>

" Add visual selection search
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

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

function! RemoveDiffHighlights()
    :highlight clear DiffAdd
    :highlight clear DiffDelete
    :highlight clear DiffChange
    :highlight clear DiffText
endfunction

" Command to toggle line numbers for copying
:command! Copymode set number! rnu! | call Toggle_SignColumn() | :IndentLinesToggle
:command! Chars :w !wc -m
:command! Erc :e $MYVIMRC
:command! RemoveDiffHi call RemoveDiffHighlights()

" View the syntax group of item under cursor
function! ShowSyntaxGroup()
    :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
endfunction

:command! ShowSynGroup call ShowSyntaxGroup()

" #######################################################
" --------------- FILE TYPE OVERRIDES -------------------
" #######################################################

autocmd FileType c call SetCOptions()
autocmd FileType cpp call SetCppOptions()
autocmd FileType fortran call SetFortranOptions()
autocmd FileType xdefaults call SetXdefaultsOptions()
autocmd FileType text,markdown setlocal spell
autocmd FileType markdown call SetMarkdownOptions()
autocmd FileType git call SetGitOptions()

source ~/.config/nvim/i3config_folding.vim
source ~/.config/nvim/vim_folding.vim

function! SetCOptions()
    setlocal expandtab
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal commentstring=//\ %s
endfunction

function! SetCppOptions()
    setlocal expandtab
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal commentstring=//\ %s
endfunction

function! SetFortranOptions()
    setlocal expandtab
    setlocal tabstop=2
    setlocal shiftwidth=2
    :syn clear fortranSerialNumber
endfunction

function! SetXdefaultsOptions()
    setlocal commentstring=!\ %s
endfunction

function! SetMarkdownOptions()
    let b:indentLine_enabled = 0
endfunction

function! SetGitOptions()
    setlocal foldlevel=20
endfunction

" Set file type for phasta input files
augroup inp_ft
  au!
  autocmd BufNewFile,BufRead *.inp   set ft=conf
augroup END
