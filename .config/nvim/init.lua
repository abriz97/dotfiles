require('plugins')

-- "hello" "world"
-- require("global")
require "global.settings"
require "global.paths"
require "global.keymappings"
require "global.luafuncs" -- LANGUAGE SERVER -- 
require "plugins.nerdtree"
require "plugins.treesitter" -- did this vanish?
require "plugins.lightline"
require "plugins.signify"
require "plugins.luasnip"
require "plugins.vimwiki"
require "plugins.quickscope"
require "plugins.browserbookmarks"
-- require "plugins.bufferline"
-- require "plugins.tabnine"
require "plugins.nvim-surround"

require 'plugins.telescope'
require "plugins.chatgpt" -- is this what's messing up with ,nn ? 
require "plugins.nvim-tree" -- requires nvim .8 or higher...

require "plugins.cmp-config"
require "plugins.lsp-config"

-- programming languages
require "plugins.nvim-R"

require "plugins.peek"

require "plugins.vimtex" --  atm got some bugs:
-- Undefined variable: g:vimtex
-- Only if I want to try editing on Overleaf through this connection
-- require "plugins.nvim-ghost"

-- view colors 
require('colorizer').setup()

-- snippets
require "misc.luasnips-R"

-- sets of colorschemes
require "plugins.catppuccin"

-- intro
require "plugins.alpha-nvim"

-- github
require "plugins.octo"


-- require "plugins.copilot"

-- HERE --

-- setup default colorscheme
vim.cmd.colorscheme "catppuccin-macchiato"


-- TODO: 
-- 1. R autocompletion doesn't suggest column names within data.table, ggplot envs
-- 4. ChatGPT as helper! 
-- 6. lets try and see whether vim-overleaf works.
--
-- 7. This looks beautiful:  https://castel.dev/post/lecture-notes-1/
