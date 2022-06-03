" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" List of plugins.
" Make sure you use single quotes

" Graphical plugins
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'                           " Toggle file explorer
Plug 'Raimondi/delimitMate'                         " Automatic closing of quotes
Plug 'patstockwell/vim-monokai-tasty'               " Monokai color scheme
Plug 'itchyny/lightline.vim'                        " Aesthics 4 tabline

" R plugins
Plug 'jalvesaq/Nvim-R'                              " Execute R code within VIM
Plug 'ncm2/ncm2'                                    " Auto complete in R
Plug 'roxma/nvim-yarp'                              " Auto complete in R
Plug 'gaalcaras/ncm-R'                              " Auto complete based on above

" Python Plugins
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " auto-completion plugin
Plug 'davidhalter/jedi-vim'
Plug 'sbdchd/neoformat'

" Stan Plugins
Plug 'egeinfoo/stan-vim'

" Initialize plugin system
call plug#end()


" Set a Local Leader

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"========================
" Plugin Related Settings
"========================

" Nvim-R
" Disable shortcut for <-
let R_assign = 0
" Not really nvim-r but basically to change hotkey for autocomplete
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>


" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine



" NCM2
" autocmd BufEnter * call ncm2#enable_for_buffer()    " To enable ncm2 for all buffers.
" set completeopt=noinsert,menuone,noselect           " :help Ncm2PopupOpen for more
                                                    " information.

" NERD Tree
map <leader>nn :NERDTreeToggle<CR>                  " Toggle NERD tree.

" Set colorscheme 
" let g:vim_monokai_tasty_italic = 1                  " Allow italics.
" colorscheme vim-monokai-tasty                       " Enable monokai theme.
" Set colorscheme
"
" 
colorscheme nord
set number
" highlight LineNr ctermfg=93
if (has("termguicolors"))
	set termguicolors
endif


" LightLine.vim
set laststatus=2              " To tell Vim we want to see the statusline.
let g:lightline = {
  \ 'colorscheme':'wombat',
  \ }

" vim-airline and vim-airline-tehmes
let g:airline_theme='bubblegum'

" jedi
let g:jedi#environment_path="/home/andrea/miniconda3/bin/python3"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

"==========================
" General NVIM/VIM Settings
"==========================

" Mouse Integration
set mouse=i                   " Enable mouse support in insert mode.

" Tabs & Navigation
map <leader>nt :tabnew<cr>      " To create a new tab.
map <leader>tt :tabonly<cr>     " To close all other tabs (show only the current tab).
map <leader>tq :tabclose<cr>    " To close the current tab.
map <leader>tm :tabmove<cr>     " To move the current tab to next position.
map <leader>ty :tabn<cr>        " To swtich to next tab.
map <leader>tr :tabp<cr>        " To switch to previous tab.

" Quoting mechs

" map <leader>' ciw'<C-R>"<esc>
" map <leader>" ciw"<C-R>"<esc>
" map <leader>` ciw`<C-R>"<esc>
" map <leader>( ciw(<C-R>"<esc>
" map <leader>[ ciw[<C-R>"<esc>
" map <leader>{ ciw{<C-R>"<esc>
" map <leader>i ciw*<C-R>"*<esc>
" map <leader>b ciw**<C-R>"**<esc>
map <leader>' c'<C-R>"<esc>
map <leader>" c"<C-R>"<esc>
map <leader>` c`<C-R>"<esc>
map <leader>( c(<C-R>"<esc>
map <leader>[ c[<C-R>"<esc>
map <leader>{ c{<C-R>"<esc>
map <leader>i c*<C-R>"*<esc>
map <leader>b c**<C-R>"**<esc>


" Control key shortcurts
" Save in Normal, Visual and Insert mode
nnoremap <silent><c-s> :<c-u>update<cr>
vnoremap <silent><c-s> <c-c>:update<cr>gv
inoremap <silent><c-s> <c-o>:update<cr>



" R shortcuts
inoremap \ff function()
inoremap \tt tmp<space><-
inoremap \t0 tmp0<space><-
inoremap \t1 tmp1<space><-
inoremap \t2 tmp2<space><-
inoremap \t3 tmp3<space><-
inoremap \t4 tmp4<space><-
inoremap \t5 tmp5<space><-
inoremap \t6 tmp6<space><-
inoremap \t7 tmp7<space><-
inoremap \t8 tmp8<space><-
inoremap \t9 tmp9<space><-

inoremap \[t tmp[]<Left>
inoremap \[0 tmp0[]<Left>
inoremap \[1 tmp1[]<Left>
inoremap \[2 tmp2[]<Left>
inoremap \[3 tmp3[]<Left>
inoremap \[4 tmp4[]<Left>
inoremap \[5 tmp5[]<Left>
inoremap \[6 tmp6[]<Left>
inoremap \[7 tmp7[]<Left>
inoremap \[8 tmp8[]<Left>
inoremap \[9 tmp9[]<Left>

" brackets around words within bracket
let @c = "i'\<Esc>ea'\<Esc>f,w"
let @q = 'F(w100@c'

" google search selection
function! GoogleSearch()
        let searchterm=getreg("g")
        silent! exec "chromium \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <F6> "gy<Esc>:call GoogleSearch()<CR>

xnoremap <f1> "zy:!firefox http://www.google.com/search?q=<c-r>=substitute(@z,' ','\\%20','g')<cr>"<return>gv

" data.table shortcuts
inoremap  \sd [,<space>lapply(.SD,)<space>,<space>.SDcols=cols]<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
inoremap  \cc cols<space><-<space>c()<Left>
inoremap  \gg grep()<Left>
inoremap  \gv grep(, value=TRUE)<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
inoremap  \gp ggplot(, aes())<Esc>7<Left>
inoremap  \uu unique()<Left>
inoremap  \un uniqueN()<Left>

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

" search between subdirectories
set path+=**

" display all matching files when Tab completing
set wildmenu

" Make Tags
command! MakeTags !ctags -R .
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

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

" Files & Backup
set nobackup                     " Turn off backup.
set nowb                         " Don't backup before overwriting a file.
set noswapfile                   " Don't create a swap file.
set ffs=unix,dos,mac             " Use Unix as the standard file type.

" Properly highlight md files
autocmd BufRead,BufNew *md setf markdown

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



"==========================
" Filetype specific cmds. 
"==========================
" R
nnoremap <leader>rscript :-1read $HOME/.vim/.skeleton.R<CR>

" Stan
autocmd BufNewFile,BufFilePre,BufRead *.stan set filetype=stan
autocmd Filetype stan nnoremap <leader>stan :-1read $HOME/.vim/.skeleton.stan<CR>
autocmd Filetype stan inoremap <silent><c-b> ****<left><left>

" R Markdown
autocmd BufNewFile,BufFilePre,BufRead *.rmd,*.Rmd set filetype=markdown
autocmd Filetype markdown map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>

autocmd Filetype markdown inoremap <silent><c-i>i **<left>
autocmd Filetype markdown inoremap <silent><c-b> ****<left><left>

