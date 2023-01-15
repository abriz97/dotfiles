local opts = { noremap = true, silent = true}

local function keymap(m, k, v, opts)
    vim.api.nvim_set_keymap(m,k,v,opts)
end

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

-- avoid using esc
keymap("i", 'jk', '<esc>', opts)
keymap("i", 'kj', '<esc>', opts)

-- Move selected piece of text in visual mode
keymap("x", "K", ":move \'<-2<CR>gv-gv\'", opts)
keymap("x", "J", ":move \'>+1<CR>gv-gv\'", opts)

-- alternative way to save
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>", opts)


-- :terminal settings

-- keymap("t", "<Esc>", "<C-\\><C-n>", opts) -- we might now want this as still want to use vi mode within.
keymap("t", "<C-w>h", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-w>j", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-w>k", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-w>l", "<C-\\><C-n><C-w>l", opts)


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


vim.cmd([[
"
" look up png
autocmd Filetype r nnoremap \wp df]igthumb<space><Esc>dd:!<C-R>"<return>

" find commas left and right
autocmd Filetype r inoremap <C-H> <Esc>F,a
autocmd Filetype r inoremap <C-L> <Esc>f,a
autocmd Filetype r,rmd nnoremap <leader>rscript :-1read $HOME/.vim/.skeleton.R<CR>
autocmd FileType r inoremap <buffer> >> <Esc>:normal! a\|><CR>a<return>
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

" open up images
autocmd Filetype r nnoremap  ;gt \oj0d2f<space>v$d:!<space>gthumb<space><C-r>"<enter>

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
"

" Macros 

" brackets around words within bracket
let @c = "i'\<Esc>ea'\<Esc>f,w"
let @q = 'F(w100@c'

]])

