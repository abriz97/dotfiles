---@diagnostic disable: undefined-global

-- local myfirstAutosnippet = s( {trig = "digit(%d%d)", regTrig = true}, {
--     i(1, "let's try this"),
--     f(function(arg, snip) -- arg takes the value of the instert node 1
--         return arg[1][1]:upper() .. arg[2][1]:lower()
--     end, {1, 2}),
--     i(2, " lowercase me"),
-- })

-- rep(1) to repeat, say i(1, "arg")

-- Dynamic nodes

local begins_line = function()
    local cur_line = vim.api.nvim_get_current_line()
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end


return nil, {

    s({ trig = "fn", regTrig = true, wordTrig = true }, 
        fmt(
            [[
            function({})
            {{
                {}
            }}
            ]]
        , {
            i(1, 'args'),
            i(2, '#TODO'),
        })
    ),

    s({ trig=';ggp', regTrig = true, wordTrig = true } ,
        fmt(
            [[
            ggplot({}, aes({})) +
                geom_{} +
                facet_{}({}) +
                theme({}) +
                labs({})
            ]]
            ,{
                i(1, 'data'),
                i(2, 'aes'),
                i(3, '.*()'),
                c(4, { t('grid'), t('wrap') }),
                i(5, ''),
                i(6, ''),
                i(7, '...'),
            })
    ),

    s({ trig=';ff',regTrig = true, wordTrig = true } ,
        fmt([[
        function({})
        {{
            {}
        }}
        ]], {
            i(1, 'args'),
            i(2, '# TODO: write here')
        }
    )),

    s({ trig=';for', regTrig = true, wordTrig = true } ,
        fmt([[
        for ( {} in {} )
        {{
            {}
        }}
        ]], {
            i(1, 'i'),
            i(2, 'idx'),
            i(3, '# TODO: write here')
        }
    )),

    s({ trig=';iff', regTrig = true, wordTrig = true } ,
        fmt([[
        if ( {} )
        {{
            {}
        }}
        ]], {
            i(1, 'cond'),
            i(2, '# TODO: write here')
        }
    )),

    s({ trig=';ife', regTrig = true, wordTrig = true } ,
        fmt([[
        if ( {} )
        {{
            {}
        }}else{{
            {}
        }}
        ]], {
            i(1, 'cond'),
            i(2, '# TODO: if code'),
            i(3, '# TODO: else code')
        }
    )),

    s({ trig='dt', regTrig = true, wordTrig = true } ,
        fmt([[
        {}[ {}, {}, by='{}' ]
        ]], {
            i(1, 'Name'),
            i(2, 'cond'),
            i(4, 'action'),
            i(3, '')
        }
    )),

    -- TODO: add value = TRUE if needed (look at choices)
    s({ trig=';gsb', regTrig = true, wordTrig = true } ,
        fmt([[ 
        gsub( {}, {}, {})
        ]], {
                i(2, 'old'),
                i(3, 'new'),
                i(1, 'var'),
            }
        )
    ),

    s({ trig=';grp', regTrig = true, wordTrig = true } ,
        fmt([[ 
        grep( {}, {}{}{} )
        ]], {
                i(1, 'pattern'),
                i(2, 'x'),
                c(3, { t(''), t(', ignore.case=TRUE') } ),
                c(4, { t(''), t(', value=TRUE') } ),
            }
        )
    ),
    
    s({ trig=';sd', regTrig = true, wordTrig = true } ,
        { 
            t('.SD = '), i(1, 'sdcols') 
        }
    ), 

    s({ trig=';0', regTrig = true, wordTrig = true } ,
        {
            t('paste0('), i(1), t(')') 
        }
    ), 

    s({ trig=';fp',regTrig = true, wordTrig = true } ,
        {
            t('file.path('), i(1, 'dir'), t(', '), i(2, 'base'), t(')')
        }
    ),

    s({ trig=';fe',regTrig = true, wordTrig = true } ,
        {
            t('file.exists('), i(1, 'path'), t(')')
        }
    ),

    s({ trig=';uu',regTrig = true, wordTrig = true } ,
        {
            t('unique('), i(1, 'var'), t(')')
        }
    ),

    s({ trig=';un',regTrig = true, wordTrig = true } ,
        {
            t('uniqueN('), i(1, 'var'), t(')')
        }
    ),

    s({ trig=';lf', regTrig = true, wordTrig = true } ,
        fmt([[
        list.files( {}, pattern="{}"{} )
        ]], {
            i(1, 'directory'),
            i(2, '.'),
            c(3, {t(''), t(', full.names=TRUE') } ),
        }
    )),

    s({ trig=';la', regTrig = true, wordTrig = true } ,
        fmt([[
        lapply( {}, {} )
        ]], {
            i(1, 'names'),
            i(2, 'function')
        }
    )),

    s({trig = '>>', wordTrig = true }, 
        fmt(
            [[
            |>
                {}
            ]],
            {
                i(1, '...')
            }
    )),


    --
    -- End Snippets --

}
