---- Telescope
local actions = require('telescope.actions')
local telebuiltin = require('telescope.builtin')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-d>'] = actions.preview_scrolling_down,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
    winblend = 20
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')

local neovim_dotfiles = {
  prompt_title = "~ Neovim dotfiles ~",
  shorten_path = false,
  cwd = "~/.config/nvim",
  follow = true,
}

local function isempty(s)
  return s == nil or s == ''
end

local function teleFDPath(input)
  print(vim.inspect(input))
  if isempty(input.args) then
    telebuiltin.find_files({follow = true})
  else
    telebuiltin.find_files({follow = true, cwd=input.args})
  end
end

-- vim.api.nvim_create_user_command('TeleFDPath', teleFDPath, {nargs=1, complete='file'})
vim.api.nvim_create_user_command('TeleFDPath', teleFDPath, {nargs=1})

local function teleGrepPath(input)
  print(vim.inspect(input))
  if isempty(input.args) then
    telebuiltin.live_grep({additional_args={'-L'}})
  else
    telebuiltin.live_grep({additional_args={'-L'}, cwd=input.args})
  end
end

vim.api.nvim_create_user_command('TeleGrepPath', teleGrepPath, {nargs=1})

--------------------
-- Telescope keymaps
local nore_sil = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ff',      function() telebuiltin.find_files({follow = true}) end,         nore_sil)
vim.keymap.set('n', '<leader>fF',      ':TeleFDPath ',                                                 {})
vim.keymap.set('n', '<leader>fn',      function() telebuiltin.find_files(neovim_dotfiles) end,         nore_sil)
vim.keymap.set('n', '<leader><space>', function() telebuiltin.buffers() end,                           nore_sil)
vim.keymap.set('n', '<leader>sb',      function() telebuiltin.current_buffer_fuzzy_find() end,         nore_sil)
vim.keymap.set('n', '<leader>sh',      function() telebuiltin.help_tags() end,                         nore_sil)
vim.keymap.set('n', '<leader>sds',     function() telebuiltin.lsp_document_symbols() end,              nore_sil)
vim.keymap.set('n', '<leader>sws',     function() telebuiltin.lsp_workspace_symbols() end,             nore_sil)
vim.keymap.set('n', '<leader>sg',      function() telebuiltin.grep_string() end,                       nore_sil)
vim.keymap.set('n', '<leader>sp',      function() telebuiltin.live_grep({additional_args={'-L'}}) end, nore_sil)
vim.keymap.set('n', '<leader>sP',      ':TeleGrepPath ',                                               {})
