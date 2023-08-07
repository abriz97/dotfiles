-- NOT IN LUA! 
-- local ok, vimtex = pcall(require, "vimtex")
-- if not ok then
--     print("Failed to load vimtex.lua")
--     return
-- end

vim.cmd( [[
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
    " Conceal latex syntax when code when cursor is not on the line
    set conceallevel=1
    let g:tex_conceal='abdmg'
    let g:vimtex_compiler_latexmk = { 
        \ 'executable' : 'latexmk',
        \ 'options' : [ 
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
    \}
]] )
