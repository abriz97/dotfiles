---@diagnostic disable: undefined-global

local begins_line = function()
    local cur_line = vim.api.nvim_get_current_line()
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end

-- from ChatGPT
function is_under_ggplot()
    local cur_buf = vim.api.nvim_get_current_buf()
    local cur_line = vim.api.nvim_win_get_cursor(0)[1]
    local ggplot_found = false
    
    for i = cur_line-1, 1, -1 do
        local line = vim.api.nvim_buf_get_lines(cur_buf, i-1, i, false)[1]
        if line ~= '' then
            if string.find(line, 'ggplot%(') then
                ggplot_found = true
                break
            else
                break
            end
        end
    end
    
    return ggplot_found
end


return {

    s({ trig="SETUP"},
        fmt(
        [[

        #################
        #      AIMS     #
        #################

        # {}

        #################
        #   Libraries   #
        #################
        
        library(data.table)
        library(ggplot2)
        {}

        # paths 

        {}

        ##################
        #      Main      #
        ##################

        {}
        ]], {i(1), i(2), i(3), i(4)})
    ),


    s({ trig = "HEAD"},
    fmt([[
    {{
        library(data.table) 
        library(ggplot2) 
        library(here) 
    }} |> suppressMessages()
    ]], {})),

    s({ trig = "OPT_START"},
    fmt([[

    library(optparse)

    option_list <- list(
        {}
    )

    args <- parse_args(OptionParser(option_list = option_list))

    ]], { i(1) })),

    s({ trig = "OPT"},
    fmt([[
        make_option(
            "--{}",
            type = "{}",
            default = {},
            help = "{}",
            dest= "{}"
        ),
    ]], {
                i(1),
                i(2),
                i(3),
                i(4),
                i(5),
    })),

    s("ROXY", fmt(
        [[
        #' {}
        #'
        #' {}
        #' @param {}
        #' 
        #' @return {}
        #' @export {}
        #' 
        #'@examples {}
        ]], {
            i(1),
            i(2),
            i(3),
            i(4),
            i(5),
            i(6),
        })),

    s({ trig = "SHINYAPP"},
        fmt(
        [[
        library(shiny) 

        ui <- fluidPage(
            {}
        )

        server <- function(input, output, session) {{
            {}
        }}

        shinyApp(ui = ui, server = server)

        ]], {
                i(1), 
                i(2) 
    })),


    s("SAVERDS", fmt(
        [[
        filename_rds <- {}
        if( file.exists(filename_rds) & !overwrite ){{
            {} <- readRDS( filename_rds )
        }} else {{
            {}
            saveRDS(object= {}, filename_rds)
        }}

        {}
        ]], {
            i(1),
            i(2),
            i(3),
            i(2),
            i(4),
        })),

    s("PROFILE", fmt(
        [[
        prof <- profvis::profvis({{
            {}
        }})
        htmlwidgets::saveWidget(prof, "~/Downloads/profile.html")
        system("chromium ~/Downloads/profile.html")
        ]], {
            i(1),
        })),

    s("CMDSTAN", fmt(
        [[ 
        model <- cmdstan_model({}, cpp_options=list(stan_threads=TRUE))
        fit <- model$sample( 
            data={},
            chains={},
            iter_warmup={},
            iter_sampling={},
            threads_per_chain={},
            parallel_chains={},
            )

        ]], {
            i(1), 
            i(2, "stan.data"),
            i(3),
            i(4),
            i(5),
            i(6, "1"),
            rep(3),
        }
    ))
    
    -- s("SECTION", fmt(
    --     [[
    --     ##{}##
    --     # {} #
    --     ##{}##
    --     ]], {

    --         t(string.rep("#", #snip.captures[1]),
    --         i(1),
    --         t(string.rep("#", #snip.captures[1]),
    --     })),

}, {

    s("++", { t{"+", ""}, i(1)  }),

    s({ trig = "f(", wordTrig = true }, 
        fmt( "function({}", { i(1, 'x') })
    ),

    s({ trig = "fn()", wordTrig = true }, 
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

    

    -- s({ trig=';ggp', regTrig = true, wordTrig = true } ,
    --     fmt(
    --         [[
    --         ggplot({}, aes({})) +
    --             geom_{} +
    --             facet_{}({}) +
    --             theme({}) +
    --             labs({})
    --         ]]
    --         ,{
    --             i(1, 'data'),
    --             i(2, 'aes'),
    --             i(3, '.*()'),
    --             c(4, { t('grid'), t('wrap') }),
    --             i(5, ''),
    --             i(6, ''),
    --             i(7, '(<>)'),
    --         })
    -- ),


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

    s({ trig='if ', wordTrig = true } ,
        fmt([[
        if ( {} )
        {{
            {}
        }}

        ]], {
            i(1, 'cond'),
            i(2, '(<>)')
        }
    ), { condition = begins_line }),

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

    s({ trig=';dt', regTrig = true, wordTrig = true } ,
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
    s({ trig='gs(', wordTrig = true } ,
        fmt([[ 
        gsub( {}, {}, {}
        ]], {
                i(2, 'old'),
                i(3, 'new'),
                i(1, 'var'),
            }
        )
    ),

    s({ trig='grp(', wordTrig = true } ,
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
    
    -- data.table stuff
    s({ trig=';sd', wordTrig = false } ,
        fmt([[
        [, lapply(.SD, {}), .{}{}]
        ]], {
            i(1, ''),
            c(2, {t('SDcols='), t('') } ),
            i(3, ''),
        }
    )),

    s({ trig=';idx', wordTrig = true } ,
        fmt([[
        idx <- {}[,.(COND={}), by='{}'][COND==TRUE, {}]
        {}[{} %in% idx]
        ]], {
            i(1, 'DT'),
            i(2, 'condition'),
            i(3),
            rep(3),
            rep(1), 
            rep(3),
        }
    )),

    s({ trig=';usr', wordTrig = true } ,
            t"usr <- Sys.info()[['user']]",
        {condition = begins_line}),

    -- dt[, lapply(.SD, {}), .SDcols={}]

    -- TODO: can we set multiple triggers for the same snippet? Also update the triggers above
    -- s({trig = "^ns%(", regTrig = true}, 
    --     {
    --         t "names(", i(1)
    --     } ),
    s({ trig='0(', wordTrig = true } , t"paste0("),

    s({trig = "bb", wordTrig = true, {condition=begins_line} }, t"browser()"),

    s({trig = "cb(", wordTrig = true}, t"cbind("),

    s({ trig='dt(', wordTrig = true } , t"data.table("),

    s({ trig='fe(', wordTrig = true } , t"file.exists("),
    
    s({ trig='fp(', wordTrig = true } , t"file.path("),

    s({trig = "l(", wordTrig = true}, t"length("),

    s({ trig='lap(', wordTrig = true } , t"lapply("),

    s({trig = "lib(", wordTrig = true}, t"library("),

    s({trig = "mg(", wordTrig = true}, t"merge("),

    s({trig = "n(", wordTrig = true}, t"names("),
        
    s({trig = "nr(", wordTrig = true}, t"nrow("),

    s({trig = "q(", wordTrig = true}, t"quantile("),

    s({trig = "q2(", wordTrig = true}, t"quantile2("),

    s({trig = "rb(", wordTrig = true}, t"rbind("),

    s({trig = "rbl(", wordTrig = true}, t"rbindlist("),

    s({trig = "s(", wordTrig = true}, t"sum("),

    s({trig = "sb(", wordTrig = true}, t"subset("),

    s({trig = "sf(", wordTrig = true}, { t'sprintf("', i(1), t'"'}),

    s({trig = "src(", wordTrig = true}, { t'source(', i(1), t''}),

    s({trig = "ss(", wordTrig = true}, { t'subset(', i(1), t')'}),

    s({ trig='sin(', wordTrig = true } , t"stopifnot("),

    -- s({trig = "tt", wordTrig = true}, t"traceback()", {condition = begins_line}),

    s({trig = "u(", wordTrig = true}, t"unique("),

    s({trig = "un(", wordTrig = true}, t"uniqueN(" ),

    s({trig = "w(", wordTrig = true}, t"which("),


    -- ggplot stuff
    s({trig = "a(", wordTrig = true}, t"aes("),

    s("ggp",  
            fmt([[
            ggplot({}) + 
                {}
                NULL
            ]], { 
                i(1),
                i(2),
            }),
            {condition = is_under_ggplot and begins_line}
    ),

    s("g_", fmt(
        [[
        geom_{}
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),

    s("geom_p", fmt(
        [[
        geom_point({}) +
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),

    s("geom_l", fmt(
        [[
        geom_line({}) +
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),

    s("geom_r", fmt(
        [[
        geom_ribbon({}) +
        ]], {
                i(1)
         }), {condition=is_under_ggplot and begins_line} 
    ),
    
    s("f_", fmt(
        [[
        facet_{} 
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),

    s("facet_g", fmt(
        [[
        facet_grid({}) +
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),

    s("facet_w", fmt(
        [[
        facet_wrap({}) + 
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),

    s("s_", fmt(
        [[
        scale_{} 
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),
    
    s("scale_c_", fmt(
        [[
        scale_color_({}) +
        ]], {
                i(1)
         }), {condition=is_under_ggplot and begins_line} 
    ),

    s("scale_f_", fmt(
        [[
        scale_fill{} 
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),

    s("t_", fmt(
        [[
        theme_{} 
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),

    s("theme_b", fmt(
        [[
        theme_bw({}) + 
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),

    s("theme_c", fmt(
        [[
        theme_classic({}) + 
        ]], {
                i(1)
    }), {condition=is_under_ggplot and begins_line}
    ),

    s({ trig='lf(', wordTrig = true } ,
        fmt([[
        list.files( {}, pattern="{}"{}
        ]], {
            i(1, 'directory'),
            i(2, ''),
            c(3, {t(''), t(', full.names=TRUE') } ),
        }
    )),

    s({ trig='melt(', wordTrig = true } ,
        fmt([[
        melt( {}, id.vars = {}, measure.vars = {}
        ]], {
            i(1, ''),
            i(2, ''),
            i(3, '' ),
        }
    )),

    s({trig = '>>', wordTrig = true }, 
        fmt(
            [[
            |>
                {}
            ]],
            {
                i(1, '(<>)')
            }
    )),

    s({trig = "%b", wordTrig = true}, t "%between% " ),
    s({trig = "%l", wordTrig = true}, t "%like% " ),
    s({trig = "%i", wordTrig = true}, t "%in% " ),

    s({trig = "TT", wordTrig = true}, t "TRUE" ),
    s({trig = "FF", wordTrig = true}, t "FALSE" ),
    s({trig = "NN", wordTrig = true}, t "NULL" ),

    s({trig = "narm", wordTrig = true}, t "na.rm=TRUE" ),




    --  +<- to x <- x +
    s({trig= "(%s+)(.+)%s+%+<%-", regTrig=true}, {
        d(1,
            function(_,snip)
            return sn(1, 
                fmt(
                    [[{}{} <- {} + {}]],
                    {
                        t(snip.captures[1]),
                        t(snip.captures[2]),
                        t(snip.captures[2]),
                        i(1),
                    }
                ))
        end, {})
    }),

    s({trig= "(%s+)(.+)%s+<%-%-", regTrig=true}, {
        d(1,
            function(_,snip)
            return sn(1, 
                fmt(
                    [[{}{} <- {}({}) ]],
                    {
                        t(snip.captures[1]),
                        t(snip.captures[2]),
                        i(1),
                        t(snip.captures[2]),
                    }
                ))
        end, {})
    }),


    -- End Snippets --

}
