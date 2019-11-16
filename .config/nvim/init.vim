" #######################################################
" -------------- GENERAL SETTINGS -----------------
" #######################################################
set number relativenumber " hybrid relative line numbers
set termguicolors     " Done due to MobaXterm not displaying cursor
" correctly

set showmatch           " Show matching brakets.
set formatoptions+=o	" Continue comment marker in new line
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
" ---------------------- PLUGINS ------------------------
" #######################################################
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'crusoexia/vim-monokai'
Plug 'tpope/vim-surround'
" Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'brennier/quicktex'
Plug 'lervag/vim-foam'
" Plug 'davidhalter/jedi-vim'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'nvie/vim-flake8'
Plug 'svermeulen/vim-subversive' " adds substitute commmmands to paste over a text object (ie. `siw`)
Plug 'chrisbra/improvedft' "allows f, t, F, and T to be used over multiple lines
Plug 'chrisbra/Colorizer' "Highlights hex values in their respective color
Plug 'mboughaba/i3config.vim' " adds i3config filetype
Plug 'Yggdroot/indentLine' " add pipe line stuff
Plug 'adelarsq/vim-matchit' " for '%' to go between do/endo and if/else/elseif/endif statements

let intellisense_plugin = "coc.nvim"

if intellisense_plugin=="ncm2"
    " <NCM2>
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
    " <NCM2/>
elseif intellisense_plugin=="coc.nvim"
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
    autocmd CursorHold * silent call CocActionAsync('highlight')
    Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
    Plug 'fannheyward/coc-markdownlint', {'do': 'yarn install --frozen-lockfile'}
    Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}

    """" DEFAULT CONFIG BELOW """""
    " if hidden is not set, TextEdit might fail.
    set hidden

    " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

    set cmdheight=2 " Better display for messages

    set updatetime=300 " diagnostic messages when it's default 4000.

    " don't give |ins-completion-menu| messages.
    set shortmess+=c

    set signcolumn=yes " always show signcolumns

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    " nmap <silent> <C-d> <Plug>(coc-range-select)
    " xmap <silent> <C-d> <Plug>(coc-range-select)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

endif

call plug#end()

" #######################################################
" ------------------ PLUGIN SETTINGS --------------------
" #######################################################

" Airline
let g:airline_powerline_fonts=1
let g:airline_theme='molokai'

let g:airline#extensions#whitespace#enabled = 1

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

" ncm2----------------------------
" custom key mapping for manual trigger
inoremap <C-space> <C-r>=ncm2#force_trigger()<cr>

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

" commentary---------------------------------
" Correct commenting on .Xdefaults and .Xresources
autocmd FileType xdefaults setlocal commentstring=!\ %s

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

function! Toggle_SignColumn()
    if &signcolumn == 'yes'
        let &signcolumn='no'
    else
        let &signcolumn='yes'
    endif
endfunction

" Command to toggle line numbers for copying
:command! Copymode set number! rnu! | call Toggle_SignColumn()

" #######################################################
" --------------- FILE TYPE OVERRIDES -------------------
" #######################################################

autocmd FileType c setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType fortran setlocal expandtab tabstop=2 shiftwidth=2

