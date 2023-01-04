--- Copied from https://github.com/echasnovski/nvim/blob/32dcf86b51454428f375e01bdf07c12363c6510d/lua/ec/configs/nvim-lspconfig.lua#L48-L53
--
---- Currently used language servers:
-- - r_language_server for R
-- - pyright for Python
-- - sumneko_lua for Lua

local lspconfig = require('lspconfig')
require('mini.completion').setup()

-- Preconfiguration ===========================================================
local on_attach_custom = function(client, bufnr)
  local function buf_set_option(name, value)
    vim.api.nvim_buf_set_option(bufnr, name, value)
  end

  buf_set_option('omnifunc', 'v:lua.MiniCompletion.completefunc_lsp')

  -- Mappings are created globally for simplicity

  -- Currently all formatting is handled with 'null-ls' plugin
  client.resolved_capabilities.document_formatting = false
end

local diagnostic_opts = {
  -- Show gutter signs
  signs = {
    -- With highest priority
    priority = 9999,
    -- Only for warnings and errors
    severity_limit = 'INFO',
  },
  underline = {
      severity_limit = 'INFO',
  },
  -- Show virtual text only for errors
  virtual_text = { severity_limit = 'ERROR' },
  -- Don't update diagnostics when typing
  update_in_insert = false,
}

--- if vim.fn.has('nvim-0.7') == 1 then
diagnostic_opts.signs.severity = { min = 'WARN', max = 'ERROR' }
diagnostic_opts.virtual_text.severity = { min = 'ERROR', max = 'ERROR' }
diagnostic_opts.underline.severity = { min = 'ERROR', max = 'ERROR' }
vim.diagnostic.config(diagnostic_opts)
--- else
---   vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
---     vim.lsp.diagnostic.on_publish_diagnostics,
---     diagnostic_opts
---   )
--- end

-- R (r_language_server) ======================================================
lspconfig.r_language_server.setup({
  on_attach = on_attach_custom,
  -- Debounce "textDocument/didChange" notifications because they are slowly
  -- processed (seen when going through completion list with `<C-N>`)
  flags = { debounce_text_changes = 150 },
})

--- -- Python (pyright) ===========================================================
--- lspconfig.pyright.setup({ on_attach = on_attach_custom })
--- 
