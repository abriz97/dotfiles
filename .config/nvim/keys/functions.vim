" google search selection
function! GoogleSearch()
        let searchterm=getreg("g")
        silent! exec "chromium \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <F6> "gy<Esc>:call GoogleSearch()<CR>
