local function lsp_setup()
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
    vim.keymap.set('n', '<space>f',  vim.lsp.buf.format,                  bufopts)
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
  local lspconfig = vim.lsp.config
  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }

  -- lspconfig['pyright'].setup{
  --   on_attach = function(client, bufnr)
  --     on_attach(client, bufnr)
  --     vim.diagnostic.config({ virtual_text = false })
  --   end,
  --   capabilities = capabilities,
  --   flags = lsp_flags,
  -- }

  vim.lsp.config('ty', {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  })
  vim.lsp.enable('ty')

  vim.lsp.config('texlab', {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  })
  vim.lsp.enable('texlab')

  vim.lsp.config('fortls', {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  })
  vim.lsp.enable('fortls')

  vim.lsp.config('clangd', {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = lsp_flags,
      cmd = {
        "clangd",
        "--completion-style=detailed",
        "--header-insertion=never",
      },
  })
  vim.lsp.enable('clangd')

  require('clangd_extensions').setup({
    inlay_hints = {
      only_current_line = true
    }
  })

  vim.lsp.config('lua_ls', {
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
  })
  vim.lsp.enable('lua_ls')

  vim.lsp.config('ltex_plus', {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      vim.diagnostic.config({ virtual_text = false })
      require('ltex_extra').setup()
    end,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
      ltex = {
        language = "en-US",
        checkFrequency = "edit",
        additionalRules = {
          enablePickyRules = true,
          motherTongue= "en-US",
          languageModel="~/.local/share/ltex_ngram/ngrams-en-20150817",
        };
      },
    },
    filetypes = { "bib", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" }
  })
  vim.lsp.enable('ltex_plus')

  vim.lsp.config('julials', {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      vim.diagnostic.config({ virtual_text = false })
    end,
    capabilities = capabilities,
    flags = lsp_flags,
  })
  vim.lsp.enable('julials')

  ---- Mason Setup ----
  require("mason").setup {
    ui = {
      icons = {
        package_installed = "✓"
      }
    }
  }

  require("mason-lspconfig").setup {
      ensure_installed = { "lua_ls" },
  }
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "barreiroleo/ltex-extra.nvim",
  },
  config = lsp_setup,
  event = { "VeryLazy" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  lazy = true,
}
