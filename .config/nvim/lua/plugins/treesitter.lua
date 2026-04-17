---- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
local function treesitter_setup()
  local treesitter = require('nvim-treesitter')
  treesitter.setup {
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath('data') .. '/site'
  }
  treesitter.install {"c", "cpp", "fortran", "python", "bash", "julia", "cmake", "comment", "cuda", "diff", "dockerfile",
      "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "hjson", "html", "json", "latex", "lua", "luadoc",
      "markdown", "markdown_inline", "matlab", "mermaid", "meson", "ninja", "perl", "regex", "rust", "scheme", "todotxt", "toml", "vim", "vimdoc", "yaml", "bibtex"}

  -- Enable treesitter highlighting
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      if
        vim.list_contains(
          treesitter.get_installed(),
          vim.treesitter.language.get_lang(args.match)
        )
      then
        vim.treesitter.start(args.buf)
      end
    end,
  })

  require("nvim-treesitter-textobjects").setup {
    select = {
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        -- ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = false,
    },
    move = {
      -- whether to set jumps in the jumplist
      set_jumps = true,
    },
  }

  -- keymaps
  -- You can use the capture groups defined in `textobjects.scm`
  vim.keymap.set({ "x", "o" }, "am", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "im", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ac", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ic", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "aa", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@parameter.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ia", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@parameter.inner", "textobjects")
  end)

  -- keymaps
  -- You can use the capture groups defined in `textobjects.scm`
  vim.keymap.set({ "n", "x", "o" }, "]m", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "]]", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
  end)

  -- -- You can also pass a list to group multiple queries.
  -- vim.keymap.set({ "n", "x", "o" }, "]o", function()
  --   require("nvim-treesitter-textobjects.move").goto_next_start({"@loop.inner", "@loop.outer"}, "textobjects")
  -- end)
  --
  -- -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
  -- vim.keymap.set({ "n", "x", "o" }, "]s", function()
  --   require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
  -- end)
  -- vim.keymap.set({ "n", "x", "o" }, "]z", function()
  --   require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
  -- end)

  vim.keymap.set({ "n", "x", "o" }, "]M", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "][", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
  end)

  vim.keymap.set({ "n", "x", "o" }, "[m", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "[[", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
  end)

  vim.keymap.set({ "n", "x", "o" }, "[M", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "[]", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
  end)

  -- Go to either the start or the end, whichever is closer.
  -- Use if you want more granular movements
  vim.keymap.set({ "n", "x", "o" }, "]d", function()
    require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "[d", function()
    require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
  end)

  local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

  -- Repeat movement with ; and ,
  -- ensure ; goes forward and , goes backward regardless of the last direction
  -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
  -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

  -- vim way: ; goes to the direction you were moving.
  vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
  vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

  -- -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
  vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
  vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
  vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
  vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
end

    -- use { 'nvim-treesitter/nvim-treesitter-context', config = get_setup('treesitter-context') }

return { 'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  config = treesitter_setup,
  build  = ':TSUpdate',
  -- event = { "VeryLazy" },
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    { 'nvim-treesitter/nvim-treesitter-context',
      opts = {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
        trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
            -- For all filetypes
            -- Note that setting an entry here replaces all other patterns for this entry.
            -- By setting the 'default' entry below, you can control which nodes you want to
            -- appear in the context window.
            default = {
                'class',
                'function',
                'method',
                'for', -- These won't appear in the context
                -- 'while',
                'if',
                -- 'switch',
                -- 'case',
            },
            -- Example for a specific filetype.
            -- If a pattern is missing, *open a PR* so everyone can benefit.
            --   rust = {
            --       'impl_item',
            --   },
        },
        exact_patterns = {
            -- Example for a specific filetype with Lua patterns
            -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
            -- exactly match "impl_item" only)
            -- rust = true,
        },

        mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      }
    },
    { 'RRethy/nvim-treesitter-endwise' },
  },
}
