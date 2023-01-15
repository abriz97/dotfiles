-- Enable neovim runtime filetype.lua
-- vim.g.do_filetype_lua = 0

-- nvim sets filetype of simple *.tex files as 'plaintex'. Override
vim.g.tex_flavor = 'tex'


vim.filetype.add({
    
    filename = {

        -- R markdown
        ['.rmd'] = 'rmd',
        ['.Rmd'] = 'rmd',
        -- stan
        ['.stan'] = 'stan',
        -- latex
        ['.tex'] = 'stan',

    },

    extension = {

        -- R markdown
        ['.rmd'] = 'rmd',
        ['.Rmd'] = 'rmd',
        -- stan
        ['.stan'] = 'stan',
        -- latex
        ['.tex'] = 'stan',

    },
    -- extension = {},
    -- pattern = {},
})
