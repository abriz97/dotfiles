-- Not needed here?
-- local ok, nvim_R = pcall(require, "nvim-R")
-- if not ok then
--     print("Failed to load nvim-R.lua")
--     return
-- end

vim.cmd( [[
" Nvim-R

" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine


" Disable shortcut for <-
let R_assign = 0

" let g:rout_follow_colorscheme = 0 " R output is highlighted with current colorscheme
" let g:Rout_more_colors = 1 " R commands in R output are highlighted
let g:R_pdfviewer="zathura"
let g:R_objbr_opendf = 0
let g:R_objbr_openlist = 0
let g:R_csv_app="terminal:vd"

" Disables omnifunc
" let R_set_omnifunc = []
" let R_auto_omni = []

let R_fun_data_1 = ['select', 'rename', 'mutate', 'filter', 'dcast', 'melt']
let R_fun_data_2 = {'ggplot': ['aes'], 'with': ['lm', 'glm', 'lmer']}

let R_nvimpager = "horizontal"

" Rmd: (send python lines of code to R through reticulate"py_run_string()")
let g:markdown_fenced_languages = ['r', 'python']
let g:rmd_fenced_languages = ['r', 'python']

let R_rmdchunk = 0


let maplocalleader = '\'
]] )
