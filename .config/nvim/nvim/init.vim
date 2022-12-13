" Always source these
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/paths.vim

"ordinary neovim
source $HOME/.config/nvim/themes/nord.vim

" Plugin Related Settings
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/jedi.vim
source $HOME/.config/nvim/plug-config/lightline.vim
source $HOME/.config/nvim/plug-config/nerdtree.vim
source $HOME/.config/nvim/plug-config/nvim-R.vim
source $HOME/.config/nvim/plug-config/ncm2.vim
source $HOME/.config/nvim/plug-config/signify.vim

" anything related to shortcuts
source $HOME/.config/nvim/keys/functions.vim
source $HOME/.config/nvim/keys/macros.vim
source $HOME/.config/nvim/keys/mappings.vim

xnoremap <f1> "zy:!firefox http://www.google.com/search?q=<c-r>=substitute(@z,' ','\\%20','g')<cr>"<return>gv

