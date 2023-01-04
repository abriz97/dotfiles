local lspconfig = require('lspconfig')

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
