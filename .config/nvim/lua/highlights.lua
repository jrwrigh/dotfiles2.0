-- File of custom-set highlight commands. Note this should be "required" after
-- the colorscheme is set. Generally this is done in the same file that the
-- colorscheme is setup (in lua/setup/monokai.lua currently)

-- Make background opacity terminal emulator dependent
-- !! Must be after colorsceme setting
vim.cmd('highlight Normal ctermbg=none guibg=none')
vim.cmd('highlight NonText ctermbg=none guibg=none')
vim.cmd('highlight LineNr ctermbg=none guibg=none')
vim.cmd('highlight clear Conceal')

