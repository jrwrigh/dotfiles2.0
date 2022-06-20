-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use 'tanvirtin/monokai.nvim'
  -- use 'crusoexia/vim-monokai'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'svermeulen/vim-subversive' --adds substitute commmmands to paste over a text object (ie. `siw`)
    -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
    -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
    -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'saadparwaiz1/cmp_luasnip'
  use 'junegunn/vim-easy-align'
  use "williamboman/nvim-lsp-installer"
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

end)

require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

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


vim.api.nvim_set_keymap('',  '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('',  '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('',  '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('',  '<C-l>', '<C-w>l', { noremap = true, silent = true })

vim.opt.showbreak = '↳    '
vim.opt.listchars:append { tab= '⇄ ', trail= '␣', extends= '❯', precedes= '❮' }

vim.opt.inccommand = 'nosplit' -- Incremental live completion
vim.opt.hlsearch   = false     -- Set highlight on search
vim.opt.hidden     = true      -- Do not save when switching buffers
vim.o.breakindent  = true      -- Enable break indent
vim.o.undofile     = true      -- Save undo history
vim.o.ignorecase   = true      -- Case insensitive searching ...
vim.o.smartcase    = true      -- ... UNLESS /C or capital in search

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.go.termguicolors = true
-- vim.cmd [[colorscheme monokai]]
-- require('monokai')
require('monokai').setup { palette = require('monokai') }
-- vim.cmd('colorscheme monokai')

-- Make background opacity terminal emulator dependent
-- !! Must be after colorsceme setting
vim.cmd('highlight Normal ctermbg=none guibg=none')
vim.cmd('highlight NonText ctermbg=none guibg=none')
vim.cmd('highlight LineNr ctermbg=none guibg=none')
vim.cmd('highlight clear Conceal')

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
--Add leader shortcuts
local nore_sil = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], nore_sil)
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], nore_sil)
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], nore_sil)
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], nore_sil)
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], nore_sil)
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], nore_sil)
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], nore_sil)

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- LSP settings
local lspconfig = require 'lspconfig' -- defined earlier
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',         '<Cmd>lua vim.lsp.buf.declaration()<CR>',                                opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',         '<Cmd>lua vim.lsp.buf.definition()<CR>',                                 opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',          '<Cmd>lua vim.lsp.buf.hover()<CR>',                                      opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>',                             opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',                                     opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>',                                 opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',                                opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>',                          opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',               opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d',         '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',                           opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d',         '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',                           opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',                         opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],    opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'sumneko_lua' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags
  }
end

lspconfig.sumneko_lua.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

---- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = {'c', 'python', 'fortran', 'bash', 'lua', 'vim'},
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}


---- nvim-comp Configuration
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

---- vim-easy-align Settings
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})

vim.g.easy_align_delimiters = {
 ['>'] = { pattern = '>>\\|=>\\|>' },
 ['/'] = {
     pattern =         '//\\+\\|/\\*\\|\\*/',
     delimiter_align = 'l',
     ignore_groups =   {'!Comment'} },
 [']']= {
     pattern =       '[[\\]]',
     left_margin =   0,
     right_margin =  0,
     stick_to_left = 0
   },
 [')']= {
     pattern =       '[()]',
     left_margin =   0,
     right_margin =  0,
     stick_to_left = 0
   },
 }

---- subversive Settings
-- s for substitute
vim.api.nvim_set_keymap('n', 's',  '<plug>(SubversiveSubstitute)',            {})
vim.api.nvim_set_keymap('n', 'ss', '<plug>(SubversiveSubstituteLine)',        {})
vim.api.nvim_set_keymap('n', 'S',  '<plug>(SubversiveSubstituteToEndOfLine)', {})

-- For doing fancy substitutions without using `:s/foo/bar/gc`
vim.api.nvim_set_keymap('n', '<leader>s',  '<plug>(SubversiveSubstituteRange)',     {})
vim.api.nvim_set_keymap('x', '<leader>s',  '<plug>(SubversiveSubstituteRange)',     {})
vim.api.nvim_set_keymap('n', '<leader>ss', '<plug>(SubversiveSubstituteWordRange)', {})

-- same as fancy substitutions, but with confirmation at each substitute
vim.api.nvim_set_keymap('n', '<leader>cr',  '<plug>(SubversiveSubstituteRangeConfirm)',     {})
vim.api.nvim_set_keymap('x', '<leader>cr',  '<plug>(SubversiveSubstituteRangeConfirm)',     {})
vim.api.nvim_set_keymap('n', '<leader>crr', '<plug>(SubversiveSubstituteWordRangeConfirm)', {})


-- Airline------------------
vim.g.airline_powerline_fonts=1
vim.g.airline_theme='molokai'

-- Change the symbol displayed for modes
vim.g.airline_mode_map = { __   = 'fff'}
vim.g.airline_mode_map = {
     __     = '-';
     c      = 'C';
     i      = 'I';
     ic     = 'I';
     ix     = 'I';
     n      = 'N';
     multi  = 'M';
     ni     = 'N';
     no     = 'N';
     R      = 'R';
     Rv     = 'R';
     s      = 'S';
     S      = 'S';
     ['^S'] = 'S';
     t      = 'T';
     v      = 'V';
     V      = 'V';
     ['^V'] = 'V';
     }

-- -- Make file line/columns section less verbose
-- if !exists('g:airline_symbols')
--       vim.g.airline_symbols = {}
--   endif
-- vim.g.airline_symbols.linenr = ''
-- vim.g.airline_symbols.maxlinenr = ''

-- vim.cmd([[ au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'maxlinenr', ':%v']) ]] )

-- Make block format line
vim.g.airline_left_sep=''
vim.g.airline_right_sep=''

-- Minimalize statusline
-- vim.g.airline_symbols.dirty = '*'
-- vim.g.airline#parts#ffenc#skip_expected_string='utf-8[unix]'

-- vim.g.airline#extensions#whitespace#enabled = 1
-- vim.g.airline#extensions#branch#displayed_head_limit = 10

--#######################################################
----------------- FILE TYPE OVERRIDES -------------------
--#######################################################

vim.cmd [[
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
augroup END ]]
