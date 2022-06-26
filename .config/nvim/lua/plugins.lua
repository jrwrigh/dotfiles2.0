local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "source <afile> | PackerCompile", group = packer_group, pattern = "plugins.lua" }
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
    use { 'tanvirtin/monokai.nvim', config = get_setup('monokai') }
    use { 'lukas-reineke/indent-blankline.nvim', config = get_setup('indent_blankline')}
    use { 'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = get_setup('gitsigns'),
    }

    use { 'nvim-treesitter/nvim-treesitter',
      config = get_setup('treesitter'),
      run    = ':TsUpdate',
    }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }

    use { 'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        { 'saadparwaiz1/cmp_luasnip' },
      },
      config = get_setup('cmp'),
    }

    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use { 'neovim/nvim-lspconfig',
      requires = {
        { "williamboman/nvim-lsp-installer", config = get_setup('lsp-installer') }
      },
      config = get_setup('lsp'),
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = get_setup('lualine'),
      after = 'monokai.nvim',
    }
    use { 'norcalli/nvim-colorizer.lua', config = get_setup('nvim-colorizer') }
    use { 'junegunn/vim-easy-align',     config = get_setup('easy_align') }
    use 'chrisbra/improvedft'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-git' -- plugin/syntax stuff for git files (commit, rebase -i, etc)
    use { 'tpope/vim-fugitive', tag='*' } -- Git commands in nvim
    use { 'rbong/vim-flog', branch='master' }  -- for browsing git log branches
    -- use 'vim-airline/vim-airline'
    -- use 'vim-airline/vim-airline-themes'
    use 'svermeulen/vim-subversive' --adds substitute commmmands to paste over a text object (ie. `siw`)

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
