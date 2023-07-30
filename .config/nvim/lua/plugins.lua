local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })

local function sourcePackerCompile(input_table)
  local filepath = input_table.file
  if not ( filepath:find("fugitive://", 1, true) == 1 ) then
    vim.api.nvim_command("source <afile> | PackerCompile")
  end
end

vim.api.nvim_create_autocmd(
  "BufWritePost",
  { callback = sourcePackerCompile, group = packer_group, pattern = "plugins.lua" }
)

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end
vim.api.nvim_command("packadd packer.nvim")
-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_setup(name)
  return string.format('require("setup/%s")', name)
end

return require("packer").startup({
  function(use)
    use 'wbthomason/packer.nvim' -- Package manager
    use { 'lewis6991/impatient.nvim' }
    use { 'numToStr/Comment.nvim', config = get_setup('comment') }
    use { 'nvim-telescope/telescope.nvim',
      -- cmd      = 'Telescope',
      -- module   = {'telescope', 'telescope.builtin'},
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
      },
      config = get_setup('telescope')
    }
    use { 'sainnhe/sonokai', config = get_setup('sonokai') }
    use { 'lukas-reineke/indent-blankline.nvim',
      config = get_setup('indent_blankline'),
    }
    use { 'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = get_setup('gitsigns'),
    }

    use { 'nvim-treesitter/nvim-treesitter',
      config = get_setup('treesitter'),
      run    = ':TSUpdate',
    }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    use { 'nvim-treesitter/nvim-treesitter-context', config = get_setup('treesitter-context') }
    use { 'nvim-treesitter/playground'}

    use { 'p00f/clangd_extensions.nvim' }
    use { 'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'dmitmel/cmp-cmdline-history' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'onsails/lspkind.nvim' },
        { 'kdheepak/cmp-latex-symbols' },
      },
      config = get_setup('cmp'),
      after = 'clangd_extensions.nvim'
    }

    use { 'L3MON4D3/LuaSnip',
      config = get_setup('luasnip'),
      requires = {
        { "rafamadriz/friendly-snippets" }
    }}
    use { 'neovim/nvim-lspconfig',
      config = get_setup('lsp'),
    }
    use { "williamboman/mason.nvim",
      requires = {
        use { "williamboman/mason-lspconfig.nvim" }
      },
      config = get_setup('mason'),
      run = ':MasonUpdate',
    }
    use { "rmagatti/goto-preview", config = get_setup('goto-preview') , after = 'telescope.nvim'}
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = get_setup('lualine'),
    }
    use { 'norcalli/nvim-colorizer.lua', config = get_setup('nvim-colorizer') }
    use { 'junegunn/vim-easy-align',     config = get_setup('easy_align') }
    use 'chrisbra/improvedft'
    use {'kylechui/nvim-surround', config = function() require("nvim-surround").setup({}) end }
    use 'tpope/vim-repeat'
    use 'tpope/vim-git' -- plugin/syntax stuff for git files (commit, rebase -i, etc)
    use 'tpope/vim-abolish' -- substitute but keep capitalization with :S/-/-/g
    use { 'tpope/vim-fugitive' } -- Git commands in nvim
    use { 'rbong/vim-flog', branch='master', config = get_setup('vim-flog')}  -- for browsing git log branches
    use 'svermeulen/vim-subversive' --adds substitute commmmands to paste over a text object (ie. `siw`)
    use { 'windwp/nvim-autopairs', config = get_setup('autopairs') }

    use { 'ThePrimeagen/refactoring.nvim', config = get_setup('refactoring') , after='telescope.nvim'}

    use { 'karb94/neoscroll.nvim', config = get_setup('neoscroll')}

    use { 'lervag/vimtex', config = get_setup('vimtex') }

    use { "folke/todo-comments.nvim", config = get_setup("todo-comments"), requires = "nvim-lua/plenary.nvim"}

    use { 'sindrets/winshift.nvim', config = get_setup("winshift"), after='sonokai' }

    use { "danymat/neogen", config = function() require('neogen').setup {} end,
        requires = "nvim-treesitter/nvim-treesitter", }

    use { "Tummetott/reticle.nvim", config = get_setup("reticle") } -- Change cursorline highlight based on active window

    if Packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})
