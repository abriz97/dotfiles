vim.cmd( [[
" Nvim-R

" Disable shortcut for <-
let R_assign = 0

" let g:rout_follow_colorscheme = 0 " R output is highlighted with current colorscheme
" let g:Rout_more_colors = 1 " R commands in R output are highlighted
let g:R_pdfviewer="zathura"
let R_show_args = 1 " show the arguments for functions with autocompletion
let g:R_objbr_opendf = 0
let g:R_objbr_openlist = 0

" Disables omnifunc
" let R_set_omnifunc = []
" let R_auto_omni = []

let R_fun_data_1 = ['select', 'rename', 'mutate', 'filter']


" Not really nvim-r but basically to change hotkey for autocomplete
" inoremap <C-Space> <C-x><C-o>
" inoremap <C-@> <C-Space>

" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

let maplocalleader = '\'
]] )
