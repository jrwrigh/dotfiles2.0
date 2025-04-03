return {
  { 'numToStr/Comment.nvim', lazy = false, opts = {} },
  -- { 'chrisbra/improvedft' }, -- Probably doesn't do anything due to overriding of f/F/t/T in treesitter
  { 'kylechui/nvim-surround', event = "VeryLazy", opts = {} },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-git' }, -- plugin/syntax stuff for git files (commit, rebase -i, etc)
  { 'tpope/vim-abolish' }, -- substitute but keep capitalization with :S/-/-/g
  { 'tpope/vim-fugitive' }, -- Git commands in nvim
  { 'svermeulen/vim-subversive' }, --adds substitute commmmands to paste over a text object (ie. `siw`)
  { 'windwp/nvim-autopairs', event = "InsertEnter", lazy = true, config = true },
  { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", opts = {} },
  { "Tummetott/reticle.nvim", opts = { always_highlight_number = true } }, -- Change cursorline highlight based on active window

  { "danymat/neogen",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      languages = {
        c = {
          template = {
            annotation_convention = "my_doxygen",
            my_doxygen = {
              { nil, "/**",          { no_results = true, type = { "func", "file", "class" } } },
              { nil, "  @file",     { no_results = true, type = { "file" } } },
              { nil, "  @brief $1", { no_results = true, type = { "func", "file", "class" } } },
              { nil, "**/",          { no_results = true, type = { "func", "file", "class" } } },
              { nil, "",             { no_results = true, type = { "file" } } },

              { nil,                "/**",            { type = { "func", "class", "type" } } },
              { "class_name",       "  @class %s",   { type = { "class" } } },
              { "type",             "  @typedef %s", { type = { "type" } } },
              { nil,                "  @brief $1",   { type = { "func", "class", "type" } } },
              { nil,                "",               { type = { "func", "class", "type" } } },
              { "tparam",           "  @tparam %s $1" },
              { "parameters",       "  @param %s $1" },
              { "return_statement", "  @return $1" },
              { nil,                "**/",            { type = { "func", "class", "type" } } },
            },
          },
        },
      },
    },
  },

  { 'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = {'¦', '┊', '┊', '┊', '┊', '┊', '┊', '┊', '┊', '┊'},
      },
      scope = {
        enabled = true,
        char = "│",
        show_start = true,
        show_end = false,
      }
    },
    event = "VeryLazy",
  },

  { 'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = {
        add          = { hl = 'GitGutterAdd', text    = '+' },
        change       = { hl = 'GitGutterChange', text = '~' },
        delete       = { hl = 'GitGutterDelete', text = '_' },
        topdelete    = { hl = 'GitGutterDelete', text = '‾' },
        changedelete = { hl = 'GitGutterChange', text = '~' },
      },
    },
    event = "VeryLazy",
  },


  { 'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1,1) end } },
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {{ 'filename', path = 1 }},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{ 'filename', path = 1 }},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    }
  },

  { 'norcalli/nvim-colorizer.lua',
    config = function()
      local DEFAULT_OPTIONS = {
        RGB      = false;         -- #RGB hex codes
        RRGGBB   = true;         -- #RRGGBB hex codes
        names    = false;         -- "Name" codes like Blue
        RRGGBBAA = false;        -- #RRGGBBAA hex codes
        rgb_fn   = false;        -- CSS rgb() and rgba() functions
        hsl_fn   = false;        -- CSS hsl() and hsla() functions
        css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        mode     = 'background'; -- Set the display mode.
        }

      require 'colorizer'.setup({
        '*';
      }, DEFAULT_OPTIONS)
    end,
  },

  { 'junegunn/vim-easy-align',
    config = function()
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
    end,
  },

  { 'rbong/vim-flog',
    lazy = true,
    cmd = { 'Flog', 'Flogsplit', 'Floggit' },
    dependencies = {
      'tpope/vim-fugitive',
    },
    config = function()
      local function FlogGraph_autocmd()
        vim.keymap.set('n', 'gab', ':<C-U>exec flog#Format(\'Floggit absorb --base %h\')<CR>')
        vim.keymap.set('n', 'gar', ':<C-U>exec flog#Format(\'Floggit absorb --base %h --and-rebase\')<CR>')
        vim.keymap.set('n', 'gaa', ':Floggit absorb ')
      end

      local cmp_augroup = vim.api.nvim_create_augroup("Flog Keymap Group", { clear = true })
      vim.api.nvim_create_autocmd( "FileType", { callback = FlogGraph_autocmd, group = cmp_augroup, pattern = "floggraph" }
      )
    end
  },

  { 'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({
          -- All these keys will be mapped to their corresponding default scrolling animation
          mappings = {},
          hide_cursor = true,          -- Hide cursor while scrolling
          stop_eof = true,             -- Stop at <EOF> when scrolling downwards
          respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
          cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
          easing_function = 'quartic',       -- Default easing function
          pre_hook = nil,              -- Function to run before the scrolling animation starts
          post_hook = nil,             -- Function to run after the scrolling animation ends
          performance_mode = false,    -- Disable "Performance Mode" on all buffers.
      })

      local t = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '150'}}
      t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '150'}}
      t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '150'}}
      t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '150'}}

      require('neoscroll.config').set_mappings(t)
    end,
  },

  { 'lervag/vimtex',
    config = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_subfile_start_local = 1
    end
  },

  { 'sindrets/winshift.nvim',
    event = "VeryLazy",
    config = function()
      require("winshift").setup({
        highlight_moving_win = true,  -- Highlight the window being moved
        focused_hl_group = "Visual",  -- The highlight group used for the moving window
        moving_win_options = {
          -- These are local options applied to the moving window while it's
          -- being moved. They are unset when you leave Win-Move mode.
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
        keymaps = {
          disable_defaults = false, -- Disable the default keymaps
          win_move_mode = {
            ["h"] = "left",
            ["j"] = "down",
            ["k"] = "up",
            ["l"] = "right",
            ["H"] = "far_left",
            ["J"] = "far_down",
            ["K"] = "far_up",
            ["L"] = "far_right",
          },
        },
        ---A function that should prompt the user to select a window.
        ---
        ---The window picker is used to select a window while swapping windows with
        ---`:WinShift swap`.
        ---@return integer? winid # Either the selected window ID, or `nil` to
        ---   indicate that the user cancelled / gave an invalid selection.
        window_picker = function()
          return require("winshift.lib").pick_window({
            -- A string of chars used as identifiers by the window picker.
            picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            filter_rules = {
              -- This table allows you to indicate to the window picker that a window
              -- should be ignored if its buffer matches any of the following criteria.
              cur_win = true, -- Filter out the current window
              floats = true,  -- Filter out floating windows
              filetype = {},  -- List of ignored file types
              buftype = {},   -- List of ignored buftypes
              bufname = {},   -- List of vim regex patterns matching ignored buffer names
            },
            ---A function used to filter the list of selectable windows.
            ---@param winids integer[] # The list of selectable window IDs.
            ---@return integer[] filtered # The filtered list of window IDs.
            filter_func = nil,
          })
        end,
      })

      vim.keymap.set('n', '<C-W>m', '<cmd>WinShift<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<C-W>s', '<cmd>WinShift swap<CR>', { noremap = true, silent = true })
    end,
  },

}
