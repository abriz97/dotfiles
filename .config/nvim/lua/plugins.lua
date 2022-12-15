
return require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim' 

    -- Configurations for Nvim LSP
    use 'neovim/nvim-lspconfig' 

    -- mini.completion for LSP
    use 'echasnovski/mini.completion' 

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'

    -- Tokionight colorscheme
    -- use 'folke/tokyonight.nvim'

end)
