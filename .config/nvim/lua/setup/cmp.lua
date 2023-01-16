---- nvim-comp Configuration
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'
local cmp = require'cmp'

-- Move geometrically down rather than via low/high score
local function SelectDown(fallback)
  if cmp.visible() then
    if cmp.core.view.custom_entries_view:is_direction_top_down() then
      cmp.select_next_item()
    else
      cmp.select_prev_item()
    end
  else
    fallback()
  end
end

-- Move geometrically up rather than via low/high score
local function SelectUp(fallback)
  if cmp.visible() then
    if cmp.core.view.custom_entries_view:is_direction_top_down() then
      cmp.select_prev_item()
    else
      cmp.select_next_item()
    end
  else
    fallback()
  end
end

local function TabComplete(fallback)
  if cmp.visible() then
    SelectUp(fallback)
  else
    cmp.complete()
  end
end

local cmdline_mappings = cmp.mapping.preset.cmdline({
  ['<C-j>']   = {c = SelectDown},
  ['<C-k>']   = {c = SelectUp},
  ['<S-Tab>'] = {c = SelectDown},
  ['<Tab>']   = {c = TabComplete},
})

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>']      = cmp.mapping.confirm({ select = false }),
    ['<C-n>']     = SelectDown,
    ['<C-p>']     = SelectUp,
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'buffer' },
  }),
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.recently_used,
      require("clangd_extensions.cmp_scores"),
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  view = {
    entries = { name = 'custom', selection_order = 'bottom_up' }
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmdline_mappings,
  sources = {
    { name = 'buffer' }
  },
  completion = {
    autocomplete = false
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmdline_mappings,
  sources = cmp.config.sources({
    { name = 'cmdline' },
    { name = 'path' },
    { name = 'cmdline_history' },
  }, {
    { name = 'cmdline' }
  }),
  completion = {
    autocomplete = false
  }
})

local orig_cmdline_config = require('cmp.config').cmdline[':']

local function FlogGraph_cmdline()
  cmp.setup.cmdline(':', {
    mapping = cmdline_mappings,
    sorting = {
      comparators = {
        cmp.config.compare.order,
      },
    },
    sources = cmp.config.sources({
      { name = 'cmdline' },
      { name = 'path' }
    }),
    completion = {
      autocomplete = false
    }
  })
end

local function Normal_cmdline()
  cmp.setup.cmdline(':', orig_cmdline_config)
end

local function FlogGraph_autocmd()
  FlogGraph_cmdline()
  local Flog_cmdline_group = vim.api.nvim_create_augroup("Flog_cmdline_group", { clear = true })
  vim.api.nvim_create_autocmd(
    "BufEnter",
    { callback = FlogGraph_cmdline, group = Flog_cmdline_group, pattern = "<buffer>" }
  )
  vim.api.nvim_create_autocmd(
    "BufLeave",
    { callback = Normal_cmdline, group = Flog_cmdline_group, pattern = "<buffer>" }
  )
end

local cmp_augroup = vim.api.nvim_create_augroup("Custom cmp.nvim", { clear = true })
vim.api.nvim_create_autocmd(
  "FileType",
  { callback = FlogGraph_autocmd, group = cmp_augroup, pattern = "floggraph" }
)
