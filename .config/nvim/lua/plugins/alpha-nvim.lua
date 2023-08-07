local ok, alpha= pcall(require, "alpha")
if not ok then
    print("Failed to load alpha-nvim.lua")
    return
end

local dashboard = require("alpha.themes.dashboard")

-- config = {
--     -- required
-- 
--     -- table of elements from top to bottom
--     -- key is arbitrary, so you can use lua's array syntax
--     layout = {},
-- 
--     -- optional
--     opts = {
--         -- number: how much space to pad on the sides of the screen
--         margin = 0,
-- 
--         -- theme-specific setup,
--         -- ran once before the first draw
-- 
--         -- when true,
--         -- use 'noautocmd' when setting 'alpha' buffer local options.
--         -- this can help performance, but it will prevent the
--         -- FileType autocmd from firing, which may break integration
--         -- with other plguins.
--         -- default: false (disabled)
--         noautocmd = bool,
-- 
--         -- table of default keymaps
--         keymap = {
--             -- nil | string | string[]: key combinations used to press an
--             -- item.
--             press = '<CR>',
--             -- nil | string | string[]: key combination used to select an item to
--             -- press later.
--             press_queue = '<M-CR>'
--         }
--     }
-- }

dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":Telescope find_files<CR>"),
    dashboard.button( "g", "  > Find word", ":Telescope live_grep<CR>"),
    dashboard.button( "b", "  > Open bookmark", ":Telescope bookmarks <CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "G", "  > git" , ":Git<CR>"),
    dashboard.button( "w", "Ω  > vimwiki", ":VimwikiIndex<CR> :set foldlevel=1<CR>"),
    dashboard.button( "<bs>", "  > Quit NVIM", ":qa<CR>"),
}
