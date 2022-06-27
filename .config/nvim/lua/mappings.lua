local nore = { noremap = true }
local nore_sil = { noremap = true, silent = true }

-- Move between panes easier
vim.api.nvim_set_keymap('', '<C-h>', '<C-w>h', nore_sil)
vim.api.nvim_set_keymap('', '<C-j>', '<C-w>j', nore_sil)
vim.api.nvim_set_keymap('', '<C-k>', '<C-w>k', nore_sil)
vim.api.nvim_set_keymap('', '<C-l>', '<C-w>l', nore_sil)

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', nore)

-- Remaps for Tabs
vim.keymap.set('n', 'tn', ':tabnew<Space>', nore)
vim.keymap.set('n', 'tl', ':tabnext<CR>',   nore)
vim.keymap.set('n', 'th', ':tabprev<CR>',   nore)
vim.keymap.set('n', 'tj', ':tabfirst<CR>',  nore)
vim.keymap.set('n', 'tk', ':tablast<CR>',   nore)

-- Terminal Mode exit
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', nore)

-- Add visual selection search
vim.keymap.set('v', '//',  [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], nore)

--------------------
-- Telescope keymaps
local telebuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff',      function() telebuiltin.find_files({follow = true}) end, nore_sil)
vim.keymap.set('n', '<leader><space>', function() telebuiltin.buffers() end,                   nore_sil)
vim.keymap.set('n', '<leader>sb',      function() telebuiltin.current_buffer_fuzzy_find() end, nore_sil)
vim.keymap.set('n', '<leader>sh',      function() telebuiltin.help_tags() end,                 nore_sil)
vim.keymap.set('n', '<leader>st',      function() telebuiltin.tags() end,                      nore_sil)
vim.keymap.set('n', '<leader>sd',      function() telebuiltin.grep_string() end,               nore_sil)
vim.keymap.set('n', '<leader>sp',      function() telebuiltin.live_grep() end,                 nore_sil)

----------------------------
---- vim-easy-align Settings
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})

------------------------
---- subversive mappings
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
