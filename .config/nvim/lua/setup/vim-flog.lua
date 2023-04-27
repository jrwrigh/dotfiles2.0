local function FlogGraph_autocmd()
  vim.keymap.set('n', 'gab', ':<C-U>exec flog#Format(\'Floggit absorb --base %h\')<CR>')
  vim.keymap.set('n', 'gar', ':<C-U>exec flog#Format(\'Floggit absorb --base %h --and-rebase\')<CR>')
  vim.keymap.set('n', 'gaa', ':Floggit absorb ')
end

local cmp_augroup = vim.api.nvim_create_augroup("Flog Keymap Group", { clear = true })
vim.api.nvim_create_autocmd( "FileType", { callback = FlogGraph_autocmd, group = cmp_augroup, pattern = "floggraph" }
)
