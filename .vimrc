call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'jalvesaq/Nvim-R'
Plug 'gaalcaras/ncm-R'
Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
Plug 'eigenfoo/stan-vim'
Plug 'terryma/vim-multiple-cursors'

" Initialize plugin system
call plug#end()


" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Set a Local Leader

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","


" Plugin Related Settings

" NERD Tree
map <leader>nn :NERDTreeToggle<CR>                  " Toggle NERD tree.

" Monokai-tasty
let g:vim_monokai_tasty_italic = 1                  " Allow italics.
colorscheme vim-monokai-tasty                       " Enable monokai theme.

" LightLine.vim 
set laststatus=2              " To tell Vim we want to see the statusline.
let g:lightline = {
   \ 'colorscheme':'monokai_tasty',
   \ }


" General NVIM/VIM Settings

" Mouse Integration
set mouse=i                   " Enable mouse support in insert mode.

" Tabs & Navigation
map <leader>nt :tabnew<cr>    " To create a new tab.
map <leader>to :tabonly<cr>     " To close all other tabs (show only the current tab).
map <leader>tq :tabclose<cr>    " To close the current tab.
map <leader>tm :tabmove<cr>     " To move the current tab to next position.
map <leader>tl :tabn<cr>        " To swtich to next tab.
map <leader>th :tabp<cr>        " To switch to previous tab.


" Line Numbers & Indentation
set backspace=indent,eol,start  " To make backscape work in all conditions.
set ma                          " To set mark a at current cursor location.
set number                      " To switch the line numbers on.
set expandtab                   " To enter spaces when tab is pressed.
set smarttab                    " To use smart tabs.
set autoindent                  " To copy indentation from current line 
                                " when starting a new line.
set si                          " To switch on smart indentation.


" Search
set ignorecase                  " To ignore case when searching.
set smartcase                   " When searching try to be smart about cases.
set hlsearch                    " To highlight search results.
set incsearch                   " To make search act like search in modern browsers.
set magic                       " For regular expressions turn magic on.


" Brackets
set showmatch                   " To show matching brackets when text indicator 
                                " is over them.
set mat=2                       " How many tenths of a second to blink 
                                " when matching brackets.


" find tags in updirectories:
set tags+=tags;$HOME


" Errors
set noerrorbells                " No annoying sound on errors.


" Color & Fonts
syntax enable                   " Enable syntax highlighting.
set encoding=utf8                " Set utf8 as standard encoding and 
                                 " en_US as the standard language.

" Enable 256 colors palette in Gnome Terminal.
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry


" Files & Backup
set nobackup                     " Turn off backup.
set nowb                         " Don't backup before overwriting a file.
set noswapfile                   " Don't create a swap file.
set ffs=unix,dos,mac             " Use Unix as the standard file type.

" Properly highlight markdown
autocmd BufRead,BufNew *md setf markdown

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"==========================
" Filetype specific cmds. 
"==========================


" R Markdown
autocmd BufNewFile,BufFilePre,BufRead *.rmd,*.Rmd set filetype=markdown
autocmd Filetype markdown map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>

autocmd Filetype markdown inoremap <silent><c-i>i **<left>
autocmd Filetype markdown inoremap <silent><c-b> ****<left><left>

" tex files
""" START
" Find next (<>)
autocmd Filetype tex nnoremap <Space><Space> /(<>)<enter>ca(

autocmd BufNewFile,BufFilePre,BufRead *.tex set filetype=tex
autocmd Filetype tex map <F5> :! pdflatex <c-r>% <enter>
autocmd Filetype tex map <F6> :! bibtex <c-r>%<BS><BS><BS>aux <enter> 

"autocmd FileType tex nnoremap <C-p>":w<Enter>;!(setsid<Space>pdflatex<Space><C-R>%<Space>&><space>/dev/null&)<Enter><Enter>j)
autocmd Filetype tex nnoremap <C-t> :w<Enter>:!bibtex<Space><C-R>%<BS><BS><BS><BS><Enter>
autocmd Filetype tex nnoremap <C-o> :!<space>setsid<Space>zathura<Space><C-R>%<BS><BS><BS>pdf<Space>&><Space>/dev/null<Space>&<Enter><Enter>

autocmd FileType tex inoremap ;fr \begin{frame}<Enter>\frametitle{}<Enter><Enter>(<>)<Enter><Enter>\end{frame}<Enter><Enter>(<>)<Esc>6kf}i.
autocmd FileType tex inoremap ;fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter>(<>)<Esc>3kA
autocmd FileType tex inoremap ;exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}{Enter}{Enter}(<>)<Esc>3kA
autocmd FileType tex inoremap ;em \emph{}<Space>(<>)<Esc>T{i
autocmd FileType tex inoremap ;bf \textbf{}<Space>(<>)<Esc>T{i
autocmd FileType tex inoremap ;it \textit{}<Space>(<>)<Esc>T{i
autocmd FileType tex inoremap ;c \cite{}<Space>(<>)<Esc>T{i
autocmd FileType tex inoremap ;p \citep{}<Space>(<>)<Esc>T{i
autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter>(<>)<Esc>3kA\item<Space>
autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter>(<>)<Esc>3kA\item<Space>
autocmd FileType tex inoremap ;r \ref{}<Space>(<>)<Esc>T{i
autocmd FileType tex inoremap ;t \begin{tabular}<Enter>(<>)<Enter>\end{tabular}<Enter><Enter>(<>)<Esc>4kA{}<Esc>i
autocmd FileType tex inoremap ;tab \begin{tableau}<Enter>\inp{(<>)}<Tab>\const{(<>)}<Tab>(<>)<Enter>(<>)<Enter>\end{tableau}<Enter><Enter>(<>)<Esc>5kA{}<Esc>i
autocmd FileType tex inoremap ;sec \section{}<Enter><Enter>(<>)<Esc>2kf}i
autocmd FileType tex inoremap ;ssec \subsection{}<Enter><Enter>(<>)<Esc>2kf}i
autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><Enter>(<>)<Esc>2kf}i
autocmd FileType tex inoremap ;beg \begin{%DELRN%}<Enter>(<>)<Enter>\end{%DELRN%}<Enter><Enter>(<>)<Esc>4kfR:MultipleCursorsFind<Space>%DELRN%<Enter>c
autocmd FileType tex inoremap ;up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex nnoremap ;up /usepackage<Enter>o\usepackage{}<Esc>i
"""END





"==========================
" From YOUTUBE
"==========================

filetype plugin on

" allows to search withing subfolders
set path+=**

" display all matching files when Tab completing
set wildmenu


