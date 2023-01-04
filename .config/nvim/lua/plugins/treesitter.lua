local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

-- extend markdown parser to rmd files
local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.rmd = "markdown" -- the someft filetype will use the python parser and queries.

configs.setup({
    ensure_installed = { "bash", "c", "javascript", "json", "lua", "python", "r", "typescript", "tsx", "css", "rust", "java", "yaml", "markdown", "markdown_inline" }, -- one of "all" or a list of languages
    ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css", "markdown" }, -- list of language that will be disabled
    },
    autopairs = {
        enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },
})
