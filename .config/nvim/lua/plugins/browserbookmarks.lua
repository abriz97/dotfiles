require('telescope').load_extension('bookmarks')

local browser_bookmarks = require('browser_bookmarks')

browser_bookmarks.setup({
    -- override default configuration values  
    selected_browser = 'chromium',
    config_dir = '/home/andrea/snap/chromium/common/chromium',
    debug=true,
})

vim.keymap.set('n', '<leader>fm', browser_bookmarks.select, {
  desc = 'Fuzzy search browser bookmarks',
})

local bookmarks = browser_bookmarks.collect()
