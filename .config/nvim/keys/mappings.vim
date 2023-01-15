" Control key shortcurts
" Save in Normal, Visual and Insert mode
nnoremap <silent><c-s> :<c-u>update<cr>
vnoremap <silent><c-s> <c-c>:update<cr>gv
inoremap <silent><c-s> <c-o>:update<cr>

" Quoting mechs
map <leader>' c'<C-R>"<esc>
map <leader>" c"<C-R>"<esc>
map <leader>` c`<C-R>"<esc>
map <leader>( c(<C-R>"<esc>
map <leader>[ c[<C-R>"<esc>
map <leader>{ c{<C-R>"<esc>
map <leader>i c*<C-R>"*<esc>
map <leader>b c**<C-R>"**<esc>

"
" R related mappings
"

" look up png
autocmd Filetype r nnoremap \wp df]igthumb<space><Esc>dd:!<C-R>"<return>

" find commas left and right
autocmd Filetype r inoremap <C-H> <Esc>F,a
autocmd Filetype r inoremap <C-L> <Esc>f,a
autocmd Filetype r,rmd nnoremap <leader>rscript :-1read $HOME/.vim/.skeleton.R<CR>
autocmd FileType r inoremap <buffer> >> <Esc>:normal! a\|><CR>a<return>
autocmd Filetype r inoremap ;ff function()
autocmd Filetype r inoremap ;p0 paste0()<Left>
autocmd Filetype r inoremap ;tt tmp<space><-
autocmd Filetype r inoremap ;t0 tmp0<space><-
autocmd Filetype r inoremap ;t1 tmp1<space><-
autocmd Filetype r inoremap ;t2 tmp2<space><-
autocmd Filetype r inoremap ;t3 tmp3<space><-
autocmd Filetype r inoremap ;t4 tmp4<space><-
autocmd Filetype r inoremap ;t5 tmp5<space><-
autocmd Filetype r inoremap ;[t tmp[]<Left>
autocmd Filetype r inoremap ;[0 tmp0[]<Left>
autocmd Filetype r inoremap ;[1 tmp1[]<Left>
autocmd Filetype r inoremap ;[2 tmp2[]<Left>
autocmd Filetype r inoremap ;[3 tmp3[]<Left>
autocmd Filetype r inoremap ;[4 tmp4[]<Left>
" data.table shortcuts

" open up images
autocmd Filetype r nnoremap  ;gt \oj0d2f<space>v$d:!<space>gthumb<space><C-r>"<enter>

" Stan
autocmd Filetype stan nnoremap <leader>stan :-1read $HOME/.vim/.skeleton.stan<CR>
autocmd Filetype stan inoremap <silent><c-b> ****<left><left>

autocmd Filetype stan map <F5> :!echo<space>"cmdstanr::cmdstan_model('<c-r>%')"\|<space>R<space>--vanilla<enter>

" R Markdown
autocmd Filetype rmd nnoremap <leader>rmd :-1read $HOME/.vim/.skeleton.rmd<CR>

autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
autocmd Filetype rmd map <F4> :!chromium<space><c-r>%<space><delete><delete><delete><delete>html<enter>

autocmd Filetype rmd inoremap ;i include=FALSE
autocmd Filetype rmd inoremap ;h hidden=TRUE

autocmd Filetype rmd inoremap ;ev eval=FALSE
autocmd Filetype rmd inoremap ;ec echo=FALSE
autocmd Filetype rmd inoremap ;w warning=FALSE
autocmd Filetype rmd inoremap ;er error=TRUE
autocmd Filetype rmd inoremap ;m message=FALSE
autocmd Filetype rmd inoremap ;res results='markup\|asis\|hold\|hide'
autocmd Filetype rmd inoremap ;fw fig.width=
autocmd Filetype rmd inoremap ;fh fig.height=

" Markdown
autocmd Filetype markdown inoremap <silent><c-i>i **<left>
autocmd Filetype markdown inoremap <silent><c-b> ****<left><left>

