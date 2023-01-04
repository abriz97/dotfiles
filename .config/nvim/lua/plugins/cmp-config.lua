-- useful links: https:
-- //vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/

vim.opt.completeopt= { 'menu' ,'menuone' , 'noselect' }

-- Set up nvim-cmp.
local cmp = require'cmp'
local luasnip = require'luasnip'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        -- specify a luasnip snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        -- Tab completion
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i" , "s"}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.expand_or_jumpable(-1) then
                luasnip.expand_or_jump(-1)
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i" , "s"}),

        -- other standard
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    -- where to take suggestions from 
    sources = cmp.config.sources({
        { name = 'nvim_lua', max_item_count = 3, priority = 5},
        { name = 'luasnip', keyword_length = 1, priority = 4 }, 
        { name = 'nvim_lsp', keyword_length = 0, priority = 3 },
        { name = 'path', keyword_length =2 , priority = 2 },
        { name = 'buffer', keyword_length = 5, priority = 1},
    }),
    -- specify appearence
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '/'
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },

    experimental = {
        ghost_text =true,
    },

})



-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--         { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--     }, {
--         { name = 'buffer' },
--     })
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})


-- diagnostics
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

-- signs
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end
sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})


--
-- Set up lspconfig.
-- 

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- LUA config

local sumneko_root = vim.fn.expand('$HOME/.config/lsp/lua-language-server')
if vim.fn.isdirectory(sumneko_root) == 1 then
    local sumneko_binary = ''
    if vim.fn.has('mac') == 1 then
        sumneko_binary = sumneko_root .. '/bin/macOS/lua-language-server'
    elseif vim.fn.has('unix') == 1 then
        sumneko_binary = sumneko_root .. '/bin/lua-language-server'
    else
        print('Unsupported system for sumneko')
    end

    lspconfig.sumneko_lua.setup({
        cmd = { sumneko_binary, '-E', sumneko_root .. '/main.lua' },
        root_dir = function(fname)
            return lspconfig.util.root_pattern('.git')(fname) or lspconfig.util.path.dirname(fname)
        end,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    -- version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Don't analyze code from submodules
                    ignoreSubmodules = true,
                    -- Don't analyze 'undo cache'
                    ignoreDir = { 'undodir' },
                    -- Make the server aware of Neovim runtime files
                    library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true },
         },
       },
     },
   })
 end

-- R config
lspconfig.r_language_server.setup({
  on_attach = on_attach,
  -- Debounce "textDocument/didChange" notifications because they are slowly
  -- processed (seen when going through completion list with `<C-N>`)
  flags = { debounce_text_changes = 150 },
})
