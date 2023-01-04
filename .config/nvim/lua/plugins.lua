require('packer').startup(function(use)
    
    -- Package manager
    use 'wbthomason/packer.nvim' 

    -- File trees
    use 'preservim/nerdtree'
    use 'nvim-tree/nvim-tree.lua'

    -- Native LSP 
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    
    -- for luasnip users
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use "rafamadriz/friendly-snippets"

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'

    -- For telescope:
    use { "nvim-telescope/telescope.nvim", tag= '0.1.0' }
    use {"nvim-telescope/telescope-fzf-native.nvim", run='make'}
    use "nvim-lua/plenary.nvim"
    use "BurntSushi/ripgrep"
    use "sharkdp/fd"

    -- Automatic closing of quotes
    use 'Raimondi/delimitMate'
    -- Monokai color scheme
    use 'patstockwell/vim-monokai-tasty'
    
    use 'bluz71/vim-nightfly-colors'
    -- use 'folke/tokyonight.nvim', { 'branch': 'main' }
    use 'arcticicestudio/nord-vim'
    use 'itchyny/lightline.vim'
    -- Tokionight colorscheme
    -- use 'folke/tokyonight.nvim'


    -- Git integration
    use 'mhinz/vim-signify'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'junegunn/gv.vim'


    use({
        "jackMort/ChatGPT.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    })

    -- note taking
    use 'vimwiki/vimwiki'

    -- Execute R code within VIM
    use 'jalvesaq/Nvim-R'                              -- Trying to update R lsp


    -- markdown live preview
    use 'davidgranstrom/nvim-markdown-preview'

    -- vim-emoji
    -- use 'junegunn/vim-emoji'
    use "GI/vim-emoji-ab"

    -- use nvim to edit overleaf files.
    -- use "user202729/vim-overleaf"
    use 'subnut/nvim-ghost.nvim'

    -- Python Plugins
end)
