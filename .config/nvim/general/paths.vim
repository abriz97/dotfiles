" Properly highlight md files
autocmd BufRead,BufNew *\.md setf markdown
autocmd BufNewFile,BufFilePre,BufRead *.stan set filetype=stan
autocmd BufNewFile,BufFilePre,BufRead *.rmd,*.Rmd set filetype=rmd
