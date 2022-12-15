" Vimscript initialization file

if (has("termguicolors"))
	set termguicolors
endif

colorscheme nightfly
let g:lightline = { 'colorscheme': 'nightfly' }

" Colors the cursor:
" let g:nightflyCursorColor = v:true

" Disables italics
"let g:nightflyItalics = v:false

" Enables floating windows with same color
let g:nightflyNormalFloat = v:true

" Disables nightflyTerminal Colors
let g:nightflyTerminalColors = v:false
