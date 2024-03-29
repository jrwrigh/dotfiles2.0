local nore = { noremap = true }
local nore_sil = { noremap = true, silent = true }
local sil = { silent = true }

-- Move between panes easier
vim.api.nvim_set_keymap('', '<C-h>', '<C-w>h', nore_sil)
vim.api.nvim_set_keymap('', '<C-j>', '<C-w>j', nore_sil)
vim.api.nvim_set_keymap('', '<C-k>', '<C-w>k', nore_sil)
vim.api.nvim_set_keymap('', '<C-l>', '<C-w>l', nore_sil)

-- Resizing panes
vim.keymap.set("n", "<Left>",  ":vertical resize +1<CR>", sil)
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", sil)
vim.keymap.set("n", "<Up>",    ":resize -1<CR>",          sil)
vim.keymap.set("n", "<Down>",  ":resize +1<CR>",          sil)

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', nore)

-- Remaps for Tabs
vim.keymap.set('n', 'tn', ':tabnew<Space>',   nore)
vim.keymap.set('n', 'tl', ':tabnext<CR>',     nore)
vim.keymap.set('n', 'th', ':tabprev<CR>',     nore)
vim.keymap.set('n', 'tj', ':tabfirst<CR>',    nore)
vim.keymap.set('n', 'tk', ':tablast<CR>',     nore)
vim.keymap.set('n', 'tq', ':tabclose<Space>', nore)

-- Terminal Mode exit
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', nore)

-- Add visual selection search
vim.keymap.set('v', '//',  [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], nore)

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

-- Return cursor to original location when escaping visual mode
-- see https://stackoverflow.com/a/23459965/7564988
vim.api.nvim_set_keymap('n', 'v',     'm`v',     nore)
vim.api.nvim_set_keymap('n', 'V',     'm`V',     nore)
vim.api.nvim_set_keymap('n', '<C-v>', 'm`<C-v>', nore)
vim.api.nvim_set_keymap('v', '<esc>', '<esc>``', nore)

-- Redirect changes operations to blackhole register
vim.keymap.set('n', 'c', '"_c', nore)
vim.keymap.set('n', 'C', '"_C', nore)

-- Run macro in q register over visual selection
vim.keymap.set('x', 'Q', ":'<,'>:normal @q<CR>", nore)
