---@diagnostic disable: undefined-global

local begins_line = function()
    local cur_line = vim.api.nvim_get_current_line()
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end


function RmdIsInRCode()
    local cur_line = vim.api.nvim_get_current_line()
    local chunkline = vim.fn.search("^[ \t]*```[ ]*{r", "bncW")
    local docline = vim.fn.search("^[ \t]*```$", "bncW")
    if chunkline == vim.fn.line(".") then
        return 2
    elseif chunkline > docline then
        return 1
    else
        -- if cur_line and cur_line ~= "" then
        --     vim.api.nvim_err_writeln("Not inside an R code chunk.")
        -- end
        return 0
    end
end

local function in_r_code_chunk()

    if RmdIsInRCode() == 1 then
        return true
    end
end

local function in_r_code_chunk_start()

    if RmdIsInRCode() == 2 then
        return true
    end

end

-- would be great if I could access to the r.lua snippets whenever i am within ```{r .... ```

return {

    s("SETUP-RMD", fmt(
        [[
        ---
         title: "{}"
         author: "{}"
         date: "`r Sys.Date()`"
         params:
            test: 0
         output: 
            html_document:
                theme: {}
                highlight: {}
                toc: true
                toc_depth: 2
                toc_float: false
         
         {} bibliography: references.bib
        ---

        ```{{r, echo=FALSE, message=FALSE, results='hide'}}
        # https://www.garrickadenbuie.com/blog/pandoc-syntax-highlighting-examples/
        # https://elastic-lovelace-155848.netlify.app/themes.html

        library(data.table)
        library(ggplot2)
        library(knitr)
        {}
        ```

        ]], {
            i(1),
            i(2, "Andrea Brizzi"),
            c(3, {
                t"default", t"journal", t"bootstrap", t"cerulean", t"cosmo", t"darkly", t"flatly", t"lumen", t"paper", t"readable", t"sandstone", t"simplex", t"spacelab", t"united", t"yeti"
            }),
            c(4, {
                t"default", t"tango", t"pygments", t"kate", t"monochrome", t"espresso", t"zenburn", t"haddock", t"breezedark", t"textmate"
            }),
            i(5, "#"),
            i(6) 
        })
    )

}, {

        s("RR", 
            fmt([[
            ```{{r {}}}
            {}
            ```

            {}
            ]], {
                    i(1),
                    i(2),
                    i(3),
                }
        ), {condition = begins_line }),

        -- titles (would possibly make more sense to capture integer and string repeat but whatever)
        s( "h1", 
            fmt([[
            # {}

            {}
            ]], {
                    i(1), i(2)
                }
            ) , {condition = begins_line}),
    
        s( "h2", 
            fmt([[
            ## {}

            {}
            ]], {
                    i(1), i(2)
                }
            ) , {condition = begins_line}),

        s( "h3", 
            fmt([[
            ### {}

            {}
            ]], {
                    i(1), i(2)
                }
            ) , {condition = begins_line}),

        -- in_r_code_chunk_start()
        s( "ii", t"include=FALSE", {condition = in_r_code_chunk_start}),
        s( "hh", t"hidden=TRUE", {condition = in_r_code_chunk_start}),
        s( "ev", t"eval=FALSE", {condition = in_r_code_chunk_start}),
        s( "ec", t"echo=FALSE", {condition = in_r_code_chunk_start}),
        s( "ww", t"warning=FALSE", {condition = in_r_code_chunk_start}),
        s( "er", t"error=TRUE", {condition = in_r_code_chunk_start}),
        s( "mm", t"message=FALSE", {condition = in_r_code_chunk_start}),
        s({ trig=';res'} ,
            fmt(
                [[
                results='{}'
                ]]
                ,{
                    c(1, {
                        t"markup", t"asis", t"hold", t"hide"
                    }),
                })
        , {condition = in_r_code_chunk_start}),

        -- hyperlinks
        s("ll",
            fmt( "[{}]({})", {i(1), i(2)})
        ),

        -- fig options
        s( "fa", {t"fig.align=", c(1, {t"'center'", t"'left'", t"'right'"}, {condition = in_r_code_chunk_start})}),
        s( "fh", t"fig.height=", {condition = in_r_code_chunk_start}),
        s( "fw", t"fig.width=", {condition = in_r_code_chunk_start}),
        s( "fh", t"fig.height=", {condition = in_r_code_chunk_start}),
        s( ".tab", t"{.tabset}"),

        s({ trig='pic'} ,
            fmt(
                [[
                ```{{r {} }}
                knitr::include_graphics({})
                ```
                
                {}
                ]]
                ,{
                    i(1),
                    i(2),
                    i(3),
                }),
            { condition = begins_line }
        ),

        s( "", {t"**", i(1), t"**"}),
    }
