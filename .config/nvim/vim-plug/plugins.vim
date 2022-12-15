" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Useful
" Toggle file explorer
Plug 'preservim/nerdtree'                           
" Automatic closing of quotes
Plug 'Raimondi/delimitMate'                         
" Monokai color scheme
Plug 'patstockwell/vim-monokai-tasty'               
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' 

" Nightfly colorscheme
Plug 'bluz71/vim-nightfly-colors'
" Tokionight
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" Graphical plugins
Plug 'arcticicestudio/nord-vim'
" Aesthics 4 tabline
Plug 'itchyny/lightline.vim'                        

" Git integration
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Snippet support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


" R plugins
" Execute R code within VIM
Plug 'jalvesaq/Nvim-R'                              " Trying to update R lsp
" Auto complete in R
" Plug 'ncm2/ncm2'                                    
" Plug 'roxma/nvim-yarp'                              
" Auto complete based on above
" Plug 'gaalcaras/ncm-R'
" For snippet completion
" Plug 'sirver/UltiSnips' " Messes up something with Tab completion
" Plug 'ncm2/ncm2-ultisnips'

" Native LSP 
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'


" Python Plugins
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " auto-completion plugin
Plug 'davidhalter/jedi-vim'
Plug 'sbdchd/neoformat'

" Stan Plugins
Plug 'egeinfoo/stan-vim'


" Initialize plugin system
call plug#end()
