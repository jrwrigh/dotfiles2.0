-- File of custom-set highlight commands. Note this should be "required" after
-- the colorscheme is set. Generally this is done in the same file that the
-- colorscheme is setup (in lua/setup/monokai.lua currently)

-- Make background opacity terminal emulator dependent
-- !! Must be after colorsceme setting
vim.cmd('highlight Normal ctermbg=none guibg=none')
vim.cmd('highlight NonText ctermbg=none guibg=none')
vim.cmd('highlight LineNr ctermbg=none guibg=none')
vim.cmd('highlight clear Conceal')

-- Highlight for treesitter-context
vim.cmd [[highlight TreesitterContext guibg=#4d5154 guisp=#ffffff gui=underline ]]
vim.cmd [[highlight TreesitterContextLineNumber guifg=#ffffff ]]

-- Spell
vim.cmd [[
hi SpellBad     gui=undercurl guisp=red term=undercurl cterm=undercurl
hi SpellCap     gui=undercurl guisp=purple term=undercurl cterm=undercurl
hi SpellLocal   gui=undercurl term=undercurl cterm=undercurl
hi SpellRare    gui=undercurl term=undercurl cterm=undercurl
]]
