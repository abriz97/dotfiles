require('packer').startup(function(use)

    -- Package manager
    use 'wbthomason/packer.nvim'

    -- File trees
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'

    -- tabs
    use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

    -- Native LSP
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'jalvesaq/cmp-nvim-r'
    use 'onsails/lspkind.nvim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- autocompletions
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- snippets
            { "rafamadriz/friendly-snippets" },

        }
    }

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'ldelossa/nvim-dap-projects'

    -- AI autocompletions
    use { 'codota/tabnine-nvim', run = "./dl_binaries.sh" }

    -- surround
    use 'kylechui/nvim-surround'

    -- alignment
    use 'godlygeek/tabular'

    -- for luasnip users
    use { "L3MON4D3/LuaSnip", run = "make install_jsregexp" }
    use 'saadparwaiz1/cmp_luasnip'
    use "rafamadriz/friendly-snippets"

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'nvim-treesitter/playground'

    -- Treesitter doesn't highlight stan currently.
    use 'eigenfoo/stan-vim'


    -- For telescope:
    use { "nvim-telescope/telescope.nvim", tag = '0.1.4' }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = 'make' }
    use "nvim-telescope/telescope-media-files.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"
    use "BurntSushi/ripgrep"
    use "sharkdp/fd"

    -- additional file navigation
    use "theprimeagen/harpoon"
    use "mbbill/undotree"

    use {
        'dhruvmanila/browser-bookmarks.nvim',
        tag = '*',
        -- requires = {
        -- --   'kkharji/sqlite.lua',
        -- --   'nvim-telescope/telescope.nvim',
        -- -- }
    }

    -- Automatic closing of quotes
    use 'Raimondi/delimitMate'


    -- Monokai color scheme
    use 'patstockwell/vim-monokai-tasty'
    -- Tokionight colorscheme
    -- use 'folke/tokyonight.nvim'
    use 'bluz71/vim-nightfly-colors'
    use 'arcticicestudio/nord-vim'
    -- use 'itchyny/lightline.vim'
    use { 'feline-nvim/feline.nvim', branch = '0.5-compat' }

    use { "catppuccin/nvim", as = "catppucin" }
    use 'sainnhe/gruvbox-material'
    use 'polirritmico/monokai-nightasty.nvim'


    -- Git integration
    use 'mhinz/vim-signify'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'junegunn/gv.vim'
    use 'pwntester/octo.nvim' -- github issues

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

    -- Execute R, and python code within VIM
    use 'jalvesaq/vimcmdline'
    use 'jalvesaq/Nvim-R' -- Trying to update R lsp

    -- markdown live preview
    use 'davidgranstrom/nvim-markdown-preview'
    use({ 'toppair/peek.nvim', run = 'deno task --quiet build:fast' })

    -- vim-emoji
    -- use 'junegunn/vim-emoji'
    -- use "GI/vim-emoji-ab"

    -- Latex
    use 'lervag/vimtex'

    -- Move quicker
    use 'unblevable/quick-scope'

    -- visualise colors, and todo comments:
    use 'norcalli/nvim-colorizer.lua'
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
            }
        end
    }

    -- use nvim to edit overleaf files.
    -- use "user202729/vim-overleaf"
    -- use 'subnut/nvim-ghost.nvim'

    -- Python Plugins

    use { 'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    }

    use 'github/copilot.vim'
    use 'liuchengxu/graphviz.vim'

    -- Focus
    use 'folke/zen-mode.nvim'
    use 'folke/twilight.nvim'



    -- HERE --

end)
