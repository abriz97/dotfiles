---@diagnostic disable: undefined-global

local begins_line = function()
    local cur_line = vim.api.nvim_get_current_line()
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end


return {

    s("SETUP-QUARTO", fmt(
        [[
        ---
         title: "{}"
         author: "Andrea Brizzi"
         date: "`r Sys.Date()`"
         format:
            {}:
        ---

       ```

        ]], {
            i(1),
            c(2, {t"revealjs", t"pptx", t"beamer"}),
        })
    ),

    s("THEME", {t'theme: "', c(1, 
        {t"beige", t"blood", t"dark", t"default", t"league", t"moon", t"night", t"serif", t"simple", t"sky", t"solarized"}
    ), t'"'}),


}, {

        -- code snippets 
        s("RR", 
            fmt([[
            ```{{r {}}}
            #| label: {}
            #| fig-cap: {}
            #| warning: false
            {}
            ```

            {}
            ]], {
                    i(1), i(4), i(5), i(2), i(3),
                }
        ), {condition = begins_line }),

        s("CC", 
            fmt([[
            ```{{ {} }}
            {}
            ```

            {}
            ]], {
                    i(1), i(2), i(3),
                }
        ), {condition = begins_line }),

        -- divs
        s("d3", 
            fmt([[
            ::: {{ {} }}
            {}
            :::

            {}
            ]], { i(1),   i(2),   i(3),   }
        ), {condition = begins_line }),
        s("d4", 
            fmt([[
            :::: {{ {} }}
            {}
            ::::

            {}
            ]], { i(1),   i(2),   i(3),   }
        ), {condition = begins_line }),
        s("d5", 
            fmt([[
            ::::: {{ {} }}
            {}
            :::::

            {}
            ]], { i(1),   i(2),   i(3),   }
        ), {condition = begins_line }),

        -- notes
        s("dn", 
            fmt([[
            ::: {{ .notes }}
            {}
            :::

            {}
            ]], { i(1),   i(2)}
        ), {condition = begins_line }),

        -- callouts
        s(".call",
            fmt([[
            .callout-{} 
            ]], {
                    c(1, { t'note', t'tip', t'warning', t'caution', t'important'}),
                }
        ), {}),

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

        -- hyperlinks
        s("ll",
            fmt( "[{}]({})", {i(1), i(2)})
        ),

        -- text style
        s( "", {t"**", i(1), t"**"}),

        s("col", fmt(
            [[
            ::: {{.columns}}

            ::: {{.column width="50%"}}
            {}
            :::

            ::: {{.column width="50%"}}
            {}
            :::

            :::
            ]], {
                i(1), i(2)
            }, {condition = begins_line}
        )),
    }
