" Nvim-R

" Disable shortcut for <-
let R_assign = 0
" Not really nvim-r but basically to change hotkey for autocomplete
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
