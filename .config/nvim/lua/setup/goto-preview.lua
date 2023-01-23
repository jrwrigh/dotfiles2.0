local gtp = require('goto-preview')
local select_to_edit_map = {
  default    = "edit",
  horizontal = "new",
  vertical   = "vnew",
  tab        = "tabedit",
}

local keymapped_buffers = {}

local function open_file(orig_window, filename, cursor_position, command)
  if orig_window ~= 0 and orig_window ~= nil then
    vim.api.nvim_set_current_win(orig_window)
  end
  pcall(vim.cmd, string.format('%s %s', command, filename))
  vim.api.nvim_win_set_cursor(0, cursor_position)
end

local function open_preview(preview_win, type)
  return function()
    local command         = select_to_edit_map[type]
    local orig_window     = vim.api.nvim_win_get_config(preview_win).win
    local cursor_position = vim.api.nvim_win_get_cursor(preview_win)
    local filename        = vim.api.nvim_buf_get_name(0)

    vim.api.nvim_win_close(preview_win, gtp.conf.force_close)
    open_file(orig_window, filename, cursor_position, command)
  end
end

local goto_preview_keymap_token = 'goto preview token'

local function nvim_buf_del_existing_keymap(buffer)
  local keymaps = vim.api.nvim_buf_get_keymap(buffer, 'n')
  for _,keymap in ipairs(keymaps) do
    if keymap.desc and string.find(keymap.desc, goto_preview_keymap_token) then
    vim.api.nvim_buf_del_keymap(buffer, 'n', keymap.lhs)
    end
  end
end

local function reset_buffer_goto_preview()
  vim.api.nvim_del_augroup_by_name("goto_preview_group")
  for _, buffer in ipairs(keymapped_buffers) do
    nvim_buf_del_existing_keymap(buffer)
  end
  keymapped_buffers = {}
end

local function goto_preview_autocmd()
  local goto_preview_group = vim.api.nvim_create_augroup("goto_preview_group", { clear = true })
  vim.api.nvim_create_autocmd(
    "WinClosed",
    { callback = reset_buffer_goto_preview, group = goto_preview_group, pattern = "<buffer>" }
  )
end

local function insert_unique(arr, value)
  for _,v in ipairs(arr) do
    if value == v then
      return
    end
  end
  table.insert(arr, value)
end

local function post_open_hook(buf, win)
  vim.keymap.set('n', '<C-v>', open_preview(win, "vertical"),   { buffer = buf, desc = goto_preview_keymap_token})
  vim.keymap.set('n', '<CR>',  open_preview(win, "default"),    { buffer = buf, desc = goto_preview_keymap_token})
  vim.keymap.set('n', '<C-x>', open_preview(win, "horizontal"), { buffer = buf, desc = goto_preview_keymap_token})
  vim.keymap.set('n', '<C-t>', open_preview(win, "tab"),        { buffer = buf, desc = goto_preview_keymap_token})
  goto_preview_autocmd()
  insert_unique(keymapped_buffers, buf)
end

require('goto-preview').setup {
  width = 120; -- Width of the floating window
  height = 15; -- Height of the floating window
  opacity = 3; -- 0-100 opacity level of the floating window where 100 is fully transparent.
  resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
  post_open_hook = post_open_hook; -- A function taking two arguments, a buffer and a window to be ran as a hook.
  -- references = { -- Configure the telescope UI for slowing the references cycling window.
  --   telescope = telescope.themes.get_dropdown({ hide_preview = false })
  -- };
  -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
  focus_on_open = true; -- Focus the floating window when opening it.
  dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
  force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
  bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
  stack_floating_preview_windows = false,
}
