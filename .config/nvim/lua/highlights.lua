-- File of custom-set highlight commands. Note this should be "required" after
-- the colorscheme is set. Generally this is done in the same file that the
-- colorscheme is setup (in lua/setup/monokai.lua currently)

-- Make background opacity terminal emulator dependent
-- !! Must be after colorsceme setting
vim.cmd('highlight Normal ctermbg=none guibg=none')
vim.cmd('highlight NonText ctermbg=none guibg=none')
vim.cmd('highlight LineNr ctermbg=none guibg=none')
vim.cmd('highlight clear Conceal')

-- Make the context indent vertical (highlights the level that you're currently
-- in) not super bright. Currently the bold setting doesn't work, but leaving
-- it just in case it starts to work at somepoint in the future.
vim.cmd [[highlight IndentBlanklineContextChar guifg=#a999c4 gui=bold ]]
vim.cmd [[highlight IndentBlanklineContextStart guisp=#ae81ff gui=underline ]]

-- Highlight for treesitter-context
vim.cmd [[highlight TreesitterContext guisp=#ffffff gui=underline ]]
vim.cmd [[highlight TreesitterContextLineNumber guifg=#ffffff ]]

-- Spell
vim.cmd [[
hi SpellBad     gui=undercurl guisp=red term=undercurl cterm=undercurl
hi SpellCap     gui=undercurl guisp=purple term=undercurl cterm=undercurl
hi SpellLocal   gui=undercurl term=undercurl cterm=undercurl
hi SpellRare    gui=undercurl term=undercurl cterm=undercurl
]]
