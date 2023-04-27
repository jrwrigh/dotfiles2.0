local function telescope_lsp_references()
  require('telescope.builtin').lsp_references {

    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
    winblend = 0,
  }
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d',       vim.diagnostic.goto_prev,  opts)
vim.keymap.set('n', ']d',       vim.diagnostic.goto_next,  opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local gtp = require('goto-preview')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD',        vim.lsp.buf.declaration,             bufopts)
  vim.keymap.set('n', 'gd',        gtp.goto_preview_definition,         bufopts)
  vim.keymap.set('n', 'K',         vim.lsp.buf.hover,                   bufopts)
  vim.keymap.set('n', 'gi',        gtp.goto_preview_implementation,     bufopts)
  vim.keymap.set('n', '<space>D',  vim.lsp.buf.type_definition,         bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename,                  bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action,             bufopts)
  vim.keymap.set('n', 'gr',        telescope_lsp_references,            bufopts)
  vim.keymap.set('n', '<space>f',  vim.lsp.buf.formatting,              bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder,    bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  -- Highlight on hover iff lsp supports it
  -- Taken from https://sbulav.github.io/til/til-neovim-highlight-references/
  if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
      vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
      vim.api.nvim_create_autocmd("CursorHold", {
          callback = vim.lsp.buf.document_highlight,
          buffer = bufnr,
          group = "lsp_document_highlight",
          desc = "Document Highlight",
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
          callback = vim.lsp.buf.clear_references,
          buffer = bufnr,
          group = "lsp_document_highlight",
          desc = "Clear All the References",
      })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local lspconfig = require('lspconfig')
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

lspconfig['pyright'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig['texlab'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

lspconfig['fortls'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

-- lspconfig['clangd'].setup{
--     on_attach = on_attach,
--     capabilities = capabilities,
--     flags = lsp_flags,
-- }
-- Use clangd_extensions, which requires setting it up instead of the lspconfig
require('clangd_extensions').setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    cmd = {
      "clangd",
      "--completion-style=detailed",
      "--header-insertion=never",
    },
  },
  extensions = {
    inlay_hints = {
      only_current_line = true
    }
  }

})

lspconfig.lua_ls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

