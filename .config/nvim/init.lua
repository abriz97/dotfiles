require('plugins')

-- require("global")
require "global.settings"
require "global.paths"
require "global.keymappings"
require "global.luafuncs" -- LANGUAGE SERVER -- 
require "plugins.nerdtree"
require "plugins.treesitter" -- did this vanish?
require "plugins.nvim-R"
require "plugins.lightline"
require "plugins.signify"
require "plugins.luasnips"

require 'plugins.telescope'
-- require "plugins.chatgpt" -- is this what's messing up with ,nn ? 
-- require "plugins.nvim-tree" -- requires nvim .8 or higher...

require "plugins.cmp-config"
require "plugins.lsp-config"
require "plugins.nvim-ghost"

-- snippets
require "misc.luasnips-R"

vim.cmd[[ colorscheme nightfly ]]
vim.g.nightflyCursorColor = true
vim.g.nightflyNormalFloat = true
vim.g.nightflyTransparent = true

-- TODOs: 
-- 1. R autocompletion doesn't suggest column names within data.table, ggplot envs
-- 2.XSnippets should be suggested first.
-- 3.XTry to set up telescope: is it possible in our version? (else maybe install latest nvim)
-- 4.XChatGPT as helper! 
-- 5. it would be good to have a markdown previewer.
-- 6. lets try and see whether vim-overleaf works.
