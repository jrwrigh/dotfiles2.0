vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.expandtab      = true -- Insert spaces when <TAB> is pressed
vim.opt.tabstop        = 4    -- Set number of spaces inserted when <TAB> is pressed
vim.opt.shiftwidth     = 4    -- Indentation amount when using << and >>
vim.opt.shiftround     = true -- Makes the shift command move in multiples of shiftwidth
vim.opt.splitbelow     = true -- Horizontal split below current
vim.opt.splitright     = true -- Vetical split to right of current
vim.opt.cursorline     = true
vim.opt.scrolloff      = 2

vim.opt.list         = true
vim.opt.showbreak    = '↳ '
vim.opt.listchars    = { tab= '⇄ ', trail= '␣', extends= '❯', precedes= '❮' }
vim.go.termguicolors = true   -- Allow use of non-256 colorschemes
vim.g.tex_conceal = 'abdmg'

vim.opt.inccommand = 'nosplit' -- Incremental live completion
vim.opt.hlsearch   = true      -- Set highlight on search
vim.opt.hidden     = true      -- Do not save when switching buffers
vim.o.breakindent  = true      -- Enable break indent
vim.o.undofile     = true      -- Save undo history
vim.o.ignorecase   = true      -- Case insensitive searching ...
vim.o.smartcase    = true      -- ... UNLESS /C or capital in search

--Decrease update time
vim.o.updatetime  = 250
vim.wo.signcolumn = 'yes'

local api = vim.api
-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  group = yankGrp,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight yank",
})

--#######################################################
----------------- FILE TYPE OVERRIDES -------------------
--#######################################################

-- vim.go.load_doxygen_syntax = true
vim.cmd [[let g:load_doxygen_syntax = 1]]
vim.cmd [[
autocmd FileType c call SetCOptions()
autocmd FileType cpp call SetCppOptions()
autocmd FileType fortran call SetFortranOptions()
autocmd FileType xdefaults call SetXdefaultsOptions()
autocmd FileType text,markdown setlocal spell
autocmd FileType markdown call SetMarkdownOptions()
autocmd FileType git call SetGitOptions()
autocmd FileType lua call SetLuaOptions()

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

function! SetLuaOptions()
    setlocal expandtab
    setlocal tabstop=2
    setlocal shiftwidth=2
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
augroup END ]]

-- vim.api.nvim_create_autocmd({'FileType'}, {
--     pattern = 'c',
--     command = 'SetCOptions()'
-- })

vim.api.nvim_create_autocmd({'BufRead','BufNewFile'}, {
    pattern = {"*.h"},
    callback = function() vim.o.filetype='c' end
})
