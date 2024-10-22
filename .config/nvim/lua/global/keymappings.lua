local opts = { noremap = true, silent = true}

local function keymap(m, k, v, opts)
    vim.api.nvim_set_keymap(m,k,v,opts)
end

-- -- set clipboard+=unnamedplus

-- Control key shortcurts
-- Save in Normal, Visual and Insert mode
keymap("n", "<C-s>", ":<c-u>update<cr>", opts)
keymap("v", "<C-s>", ":<c-c>:update<cr>gv", opts)
keymap("i", "<C-s>", ":<c-o>:update<cr>", opts)

-- better window movement
keymap("n", "<C-h>", "<C-w>h", {silent=TRUE} )
keymap("n", "<C-j>", "<C-w>j", {silent=TRUE} )
keymap("n", "<C-k>", "<C-w>k", {silent=TRUE} )
keymap("n", "<C-l>", "<C-w>l", {silent=TRUE} )

-- better group indenting
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

-- center after moving through instances of a search
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- avoid using esc
keymap("i", 'jk', '<esc>', opts)
keymap("i", 'kj', '<esc>', opts)

-- Move selected piece of text in visual mode
keymap("v", "J", ":move \'>+1<CR>gv=gv\'", opts)
keymap("v", "K", ":move \'<-2<CR>gv=gv\'", opts)

keymap("n", "J", "mzJ`z", opts)

-- alternative way to save
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>", opts)


-- :terminal settings

-- keymap("t", "<Esc>", "<C-\\><C-n>", opts) -- we might now want this as still want to use vi mode within.
keymap("t", "<C-w>h", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-w>j", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-w>k", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-w>l", "<C-\\><C-n><C-w>l", opts)


-- copy to clipboard
keymap("n", "<leader>y", "\"+y", opts)
keymap("v", "<leader>y", "\"+y", opts)
keymap("n", "<leader>Y", "\"+y", opts)


-- " Quoting mechs
-- keymap("<leader>'", "c'<C-R>\"<esc>")
-- keymap("<leader>\"", "c\"<C-R>\"<esc>")
-- keymap("<leader>`", "c`<C-R>\"<esc>")
-- keymap("<leader>(", "c(<C-R>\"<esc>")
-- keymap("<leader>[", "c[<C-R>\"<esc>")
-- keymap("<leader>{", "c{<C-R>\"<esc>")
-- keymap("<leader>i", "c*<C-R>\"*<esc>")
-- keymap("<leader>b", "c**<C-R>\"**<esc>")


local function code_keymap()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
            vim.schedule(CodeRunner)
        end
    })
end

function CodeRunner ()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local fname = vim.fn.expand "%:p:t"
    local keymap_c = {}

    if ft == "python" then
        keymap_c = {
            name = "Code",
            r = {"<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<CR>", "Run"},
            m = {"<cmd>TermExect cmd='nodemon -e py %'<CR>", "Monitor"}
        }
    elseif ft == "lua" then
        keymap_c = {
            name = "Code",
            r = {"<cmd>luafile %<cr>", "Run" },
        }

    elseif true then
        
        
    end
end

function openWithExternal()
    local selected_text = vim.fn.getreg('"')
    -- local file_path = vim.fn.expand('%:p:h') .. '/' .. selected_text
    local command = 'zathura'
    vim.fn.system(command .. ' ' .. vim.fn.shellescape(selected_text) )
end

-- keymap('v', '<leader>o', ":lua openWithExternal() <CR>", opts)



-- 
-- "
-- " R related mappings
-- "

--[[ -- just trying out

local group = vim.api.nvim_create_augroup("PersonalAutocmds", { clear = true })

local function ft_keymap(m, k, v, opts)
    vim.api.nvim_set_keymap(m,k,v,opts)
end

vim.api.nvim_create_autocmd( "FileType", {
    pattern = {"r"},
    callback = function ()
        vim.schedule(function ()
            print("Hey! we got called")
        end)
    end,
})

]]

-- g/^[[:blank:]]*debug()[[:blank:]]*$/d 

vim.cmd([[
"

" find commas left and right
autocmd Filetype r inoremap <C-H> <Esc>F,a
autocmd Filetype r inoremap <C-L> <Esc>f,a

autocmd Filetype r,rmd nnoremap <leader>rscript :-1read $HOME/.vim/.skeleton.R<CR>
autocmd FileType r inoremap <buffer> >> <Esc>:normal! a\|><CR>a<return>

" run scripts, perform packae tests and style file
autocmd Filetype r map <F5> :!Rscript<space><c-r>%<enter>
autocmd Filetype r map <F6> :!echo<space>"devtools::load_all(); devtools::test(stop_on_failure=TRUE)"\|<space>R<space>--vanilla<enter>
autocmd Filetype r map \= :w<enter>:!echo<space>"styler::style_file(\"<c-r>%\")"\|<space>R<space>--vanilla<enter>

autocmd Filetype r map <F9> :g!/^\[\[:blank:\]\]\*debug()\[\[:blank:\]\]\*$/d<CR>
autocmd Filetype r map \sh :RSend<space>shiny::runApp()<enter>
autocmd Filetype r map \tt :RSend<space>traceback()<enter>


" Stan
autocmd Filetype stan nnoremap <leader>stan :-1read $HOME/.vim/.skeleton.stan<CR>
autocmd Filetype stan inoremap <silent><c-b> ****<left><left>

autocmd Filetype stan inoremap <Space><Space> <Esc>/(<>)<return>ca(
autocmd Filetype stan inoremap ;fun type<space>(<>)((<>))<space>{<return>}<Esc>k0w
autocmd Filetype stan inoremap ;for for<space>(X<space>in<space>(<>))<space>{<return>}<Esc>k0fXcl
autocmd Filetype stan inoremap ;i int;<Esc>i
autocmd Filetype stan inoremap ;r real;<Esc>i
autocmd Filetype stan inoremap ;v vector[(<>)]<space>(<>);<Esc>F[i
autocmd Filetype stan inoremap ;rv rowvector[(<>)]<space>(<>);<Esc>F[i
autocmd Filetype stan inoremap ;a array[]<space>(<>);<Esc>F[a
autocmd Filetype stan inoremap ;m matrix[(<>),(<>)]<space>(<>);<Esc>F[i

autocmd Filetype stan inoremap ;l lower=
autocmd Filetype stan inoremap ;u upper=

autocmd Filetype stan map <F5> :!echo<space>"cmdstanr::cmdstan_model('<c-r>%')"\|<space>R<space>--vanilla<enter>

" Format Stan file with stanc on key press and replace file contents
autocmd Filetype stan nnoremap <F6> :silent %!stanc --print-canonical <c-r>% <CR>


" R Markdown
autocmd Filetype rmd nnoremap <leader>rmd :-1read $HOME/.vim/.skeleton.rmd<CR>
autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<space><enter>
autocmd Filetype rmd map <F4> :!chromium<space><c-r>%<space><delete><delete><delete><delete>html<enter>

" Markdown
autocmd Filetype markdown inoremap <silent><c-i>i **<left>
autocmd Filetype markdown inoremap <silent><c-b> ****<left><left>

" open up images
" autocmd Filetype r nnoremap  ;gt \oj0d2f<space>v$d:!<space>gthumb<space><C-r>"<enter>
" look up png
" autocmd Filetype r nnoremap \wp df]igthumb<space><Esc>dd:!<C-R>"<return>
" open pdf(p) and png (o)
autocmd Filetype r xnoremap <leader>o y<Esc>:!gthumb<space><C-R>"<space>&<enter>
autocmd Filetype r xnoremap <leader>p y<Esc>:!gthumb<space><C-R>"<space>&<enter>
"

autocmd Filetype python map <F5> :!python<space><c-r>%<enter>
autocmd Filetype python map <F6> :!black<space><C-R>%<CR>

autocmd Filetype dot map <F5> :Graphviz!<CR>

" Macros 

" brackets around words within bracket
let @c = "i'\<Esc>ea'\<Esc>f,w"
let @q = 'F(w100@c'

]])

