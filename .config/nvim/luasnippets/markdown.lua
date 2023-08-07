---@diagnostic disable: undefined-global

return {

    },

    {
        -- Markdown: Definition comment tag
        s(
            "defn",
            fmt(
                [[
                <!-- Definition: {} -->

                > **{}:** {}
            ]],
                {
                    i(1),
                    rep(1),
                    i(0),
                }
            )
        ),
        -- Markdown: Embed image
        s("img", {
            t("![](./"),
            i(0),
            t(")"),
        }),


        -- Markdown: Headers
        s({ trig = "^%s*h(%d)", regTrig = true }, {
            f(function(_, snip)
                return string.rep("#", snip.captures[1])
            end),
        }),

        -- Markdown: visual subs
        s("<-", t("←")),
        s("->", t("→")),
        s("<=", t("⇐")),
        s("=>", t("⇒")),
        s("<=", t("≤")),
        s(">=", t("≥")),

            
        -- End Snippets --
    }
