local ok, telescope = pcall(require, "telescope")
if not ok then
    print("Failed to load telescope.lua")
    return
end

local telescope = require('telescope')
local telescope_themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local fzf = telescope.load_extension('fzf')
local bookmarks = telescope.load_extension('bookmarks')

telescope.load_extension('bookmarks')
local browser_bookmarks = require('browser_bookmarks')

telescope.load_extension('media_files')

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
telescope.setup {

    defaults = {
        file_ignore_patterns = { "tags", "html" },

    },

    extensions = {
        ['ui-select'] = {
            telescope_themes.get_dropdown {
                layout_config = {
                    width = 0.8,
                    height = 0.8,
                }
            },
            specific_opts = {
                ['browser-bookmarks'] = {
                    make_displayer = function()
                        return entry_display.create {
                            separator = ' ',
                            items = {
                                { width = 0.5 },
                                { remaining = true },
                            },
                            -- Use this instead if `buku_include_tags` is true:
                            -- items = {
                            --   { width = 0.3 },
                            --   { width = 0.2 },
                            --   { remaining = true },
                            -- },
                        }
                    end,
                    make_display = function(displayer)
                        return function(entry)
                            return displayer {
                                entry.value.text.name,
                                -- Uncomment if `buku_include_tags` is true:
                                -- { entry.value.text.tags, 'Special' },
                                { entry.value.text.url, 'Comment' },
                            }
                        end
                    end,
                },
            },
        },

        media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg"
        },

        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },

        bookmarks = {
            selected_browser = 'chromium',
            config_dir = '/home/andrea/snap/chromium/common/chromium',
            -- Either provide a shell command to open the URL
            url_open_command = 'xdg-open',
            -- Or provide the plugin name which is already installed
            -- Available: 'vim_external', 'open_browser'
            -- url_open_plugin = 'open_browser',
            -- Show the full path to the bookmark instead of just the bookmark name
            full_path = false,
            -- Provide a custom profile name for the selected browser
            profile_name = nil,
            -- Add a column which contains the tags for each bookmark for buku
            buku_include_tags = false,
            -- Provide debug messages
            debug = true,

        },

    }
}

-- new functions?

local M = {}

function M.live_grep()
    builtin.live_grep {
        path_display={'shorten'},

        layout_strategy = 'horizontal',
    }
end

function M.help_tags()

    builtin.help_tags {
        path_display={'smart'},
        heigth = 10,

        layout_strategy = 'horizontal',
        layout_config = {
            width = 0.9,
            preview_width = 0.7,
        },
    }

end

function M.edit_neovim()

    builtin.find_files {
        path_display={'smart'},
        cwd = "~/.config/nvim",
        prompt = "~ dotfiles ~",
        heigth = 10,

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75
        },
    }

end

function M.browse_vimwiki()

    builtin.find_files {
        path_display={'smart'},
        cwd = "~/vimwiki/",
        prompt = "~ vimwiki files~",
        height = 10,

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75
        },
    }

end

-- maybe look at builtin registers


-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fg', M.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', M.help_tags, {})
vim.keymap.set('n', '<leader>fm', browser_bookmarks.select, {
    desc = 'Fuzzy search browser bookmarks',
})
vim.keymap.set('n', '<leader>fc', M.edit_neovim, {})
vim.keymap.set('n', '<leader>fw', M.browse_vimwiki, {})
