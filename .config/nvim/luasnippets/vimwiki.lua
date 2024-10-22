---@diagnostic disable: undefined-global

-- TODO: in wimwiki, tab is already preoccupied with switching across links, should probably change that.
-- changed, but still tab prefers to "expand 4 chars", rather than moving to next snippet node 

local conds_expand = require("luasnip.extras.conditions.expand")

local begin_line = conds_expand.line_begin


return {

    },

    {
        -- Headers: todo: transform this to =1, =2, ... 
        -- s({ trig = "^%s*(=-) ", regTrig = true }, 
        --     fmt(
        --         [[
        --         {} {} {}

        --         {}
        --         ]]
        --         , {
        --             f(function(_, snip) return snip.captures[1] end),
        --             i(1),
        --             f(function(_, snip) return snip.captures[1] end),
        --             i(2),
        --         }
        --     ),
        --     { condition = begin_line }
        -- ),


        -- visual substitution
        s("<-", t("←")),
        s("->", t("→")),
        s("<=", t("⇐")),
        s("=>", t("⇒")),
        s("<=", t("≤")),
        s(">=", t("≥")),

        -- shortcuts
        s("cts", t "continuous" ),
        s("b4", t "before" ),
        s("B4", t "Before" ),
        s("tr4", t "therefore" ),
        s("Tr4", t "Therefore" ),
        s("param", t "parameter" ), -- can we make sure this also works with 'hyperparams'?


        -- links
        s({trig="ll", wordTrig=true}, fmt("[{}]({})", {i(1), i(2)}) ),

        -- math mode
        s({trig="mm", wordTrig=true}, fmt("${}$", {i(1)}) ),
       

        -- Code chunks
        s("CC", fmt(
            [[
            ```{{{}}}
            {}
            ```

            {}
            ]], {
                i(2),
                i(1),
                i(3, "(<>)")
            }), {
                condition = begin_line
            }),

        -- code snippet of R
        s("RR", fmt(
            [[
            ```{{R}}
            {}
            ```

            {}
            ]], {
                i(1),
                i(2, "(<>)")
            }), {
                condition = begin_line
            }),

        -- and for python...
        s("PP", fmt(
            [[
            ```{{python}}
            {}
            ```

            {}
            ]], {
                i(1),
                i(2, "(<>)")
            }), {
                condition = begin_line
            }),

            


        -- End Snippets --
    }
