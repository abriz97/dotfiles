local lsp = require("lsp-zero")

mason = require("mason")
mason.setup()

-- attach lsps through mason
require('mason-lspconfig').setup({
  handlers = {
    lsp.default_setup,
    tsserver = function()
      require('lspconfig').tsserver.setup({
        single_file_support = false,
        on_attach = function(client, bufnr)
          print('hello tsserver')
        end
      })
    end,
  }
})




lsp.on_attach(function(client, bufnr)
-- see :help lsp-zero-keybindings
-- to learn the available actions
lsp.default_keymaps({buffer = bufnr})
end)

lsp.preset("recommended")
-- lsp.ensure_installed({
--     "r_language_server",
--     "rust_analyzer"
-- })

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings =  lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete()
})

cmp.setup({
  sources = {
    {name = 'luasnip'},
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
end)

lsp.setup()

-- fix diagnostic options and avoid shit
local diagnostic_opts = {
    signs = {
        priority = 9999,
        severity_limit = 'INFO',
        severity = { min = 'WARN', max = 'ERROR' },
    },
    underline = {
        severity = { min = 'ERROR', max = 'ERROR' }, 
        severity_limit = 'INFO',
    },
    virtual_text = { 
        severity_limit = 'ERROR',
        severity = { min = 'ERROR', max = 'ERROR' },
    },
    update_in_insert = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
}
vim.diagnostic.config(diagnostic_opts)
