local monokai = require('monokai')
monokai.setup {
  palette = {
    base5 = '#606569',
    },
}

-- Make background opacity terminal emulator dependent
-- !! Must be after colorsceme setting
vim.cmd('highlight Normal ctermbg=none guibg=none')
vim.cmd('highlight NonText ctermbg=none guibg=none')
vim.cmd('highlight LineNr ctermbg=none guibg=none')
vim.cmd('highlight clear Conceal')

