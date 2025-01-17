---@diagnostic disable: undefined-global

local GREEK_LETTERS = {}
GREEK_LETTERS["a"] = "alpha"
GREEK_LETTERS["b"] = "beta"
GREEK_LETTERS["c"] = "gamma"
GREEK_LETTERS["d"] = "delta"
GREEK_LETTERS["e"] = "epsilon"
GREEK_LETTERS["f"] = "phi"
GREEK_LETTERS["g"] = "gamma"
GREEK_LETTERS["h"] = "theta"
GREEK_LETTERS["i"] = "iota"
GREEK_LETTERS["l"] = "lambda"
GREEK_LETTERS["m"] = "mu"
GREEK_LETTERS["n"] = "nu"
GREEK_LETTERS["o"] = "omega"
GREEK_LETTERS["p"] = "pi"
GREEK_LETTERS["r"] = "rho"
GREEK_LETTERS["s"] = "sigma"
GREEK_LETTERS["t"] = "tau"

--[[ local MATH_MODES = {
    displayed_equation = true,
    inline_formula = true,
    math_environment = true,
}

-- TS isn't updating the syntax tree on edit
local ts_utils = require("nvim-treesitter.ts_utils")
local in_math = function()
    local cur = ts_utils.get_node_at_cursor()
    while cur do
        if MATH_MODES[cur:type()] then
            return true
        end
        cur = cur:parent()
    end
    return false
end ]]

local line_begin = require("luasnip.extras.expand_conditions").line_begin


local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local in_align = function()
    return vim.fn["vimtex#env#is_inside"]("align")[1] ~= 0
end

local in_equation = function()
    return vim.fn["vimtex#env#is_inside"]("equation")[1] ~= 0
end



return nil,
    {
        -- LaTeX: Lowercase and upper case greek letters
        s({ trig = ";(%l)", regTrig = true, wordTrig = false }, {
            f(function(_, snip)
                if GREEK_LETTERS[snip.captures[1]] then
                    return "\\" .. GREEK_LETTERS[snip.captures[1]]
                end
                return ""
            end),
        }, { condition = in_mathzone }),

        s({ trig = ";(%u)", regTrig = true, wordTrig = false }, {
            f(function(_, snip)
                local greek_letter = GREEK_LETTERS[string.lower(snip.captures[1])]
                if greek_letter then
                    return "\\" .. greek_letter:gsub("^%l", string.upper)
                end
                return ""
            end),
        }, { condition = in_mathzone }),

        s({trig = "~"}, t "\\sim", {condition = in_mathzone }),
        
        -- LaTeX: Math subscripts and superscripts
        s(
            { trig = "(%a)(%d)", regTrig = true, wordTrig = false },
            f(function(_, snip)
                return snip.captures[1] .. "_" .. snip.captures[2]
            end),
            { condition = in_mathzone }
        ),
        s({ trig = "__", wordTrig = false }, {
            t("_{"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),

        -- s({ trig = "_([^%s]+) ", regTrig = true, wordTrig = false},
        --     f( function (_, snip)
        --         return "_{" .. snip.captures[1] .. "} "
        --     end), 
        --     {condition = in_mathzone }),

        s("pmat", fmt(
            [[
            \begin{{pmatrix}}
            {}
            \end{{pmatrix}}
            {}
            ]], {
                i(1), i(2)
            }),  
            { condition = in_mathzone }),


        s({ trig = "^^", wordTrig = false }, {
            t("^{"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),

        s({ trig = "^-", wordTrig = false }, {
            t("^{-"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),

        -- LaTeX: symbols shortcupts
        s({ trig = "<=", wordTrig = false }, t("\\leq"), { condition = in_mathzone }),
        s({ trig = ">=", wordTrig = false }, t("\\geq"), { condition = in_mathzone }),
        s({ trig = "xx", wordTrig = false }, t("\\times "), { condition = in_mathzone }),
        s({ trig = "ox", wordTrig = true }, t("\\otimes "), { condition = in_mathzone }),
        s({ trig = "o+", wordTrig = false }, t("\\oplus "), { condition = in_mathzone }),
        s({ trig = "**", wordTrig = false }, t("\\cdot "), { condition = in_mathzone }),

        s({ trig = "UU", wordTrig = false }, t("\\cup "), { condition = in_mathzone }),

        
        -- LaTeX: In Math fonts 
        s("bf", fmt([[\mathbf{{{}}}]], i(1)), { condition = in_mathzone }),
        s("it", fmt([[\mathit{{{}}}]], i(1)), { condition = in_mathzone }),
        s("rm", fmt([[\mathrm{{{}}}]], i(1)), { condition = in_mathzone }),
        s("cal", fmt([[\mathcal{{{}}}]], i(1)), { condition = in_mathzone }),
        s("scr", fmt([[\mathscr{{{}}}]], i(1)), { condition = in_mathzone }),
        s({ trig = "tt", wordTrig = false }, fmt([[\text{{{}}}]], i(1)), { condition = in_mathzone }),

        -- LaTeX: Parenthesis-delimited fractions
        s({ trig = "(%b())/", regTrig = true, wordTrig = false }, {
            d(1, function(_, snip)
                return sn(
                    1,
                    fmt(
                        [[
                    \frac{{{}}}{{{}}}
                ]],
                        {
                            t(string.sub(snip.captures[1], 2, #snip.captures[1] - 1)),
                            i(1),
                        }
                    )
                )
            end, {}),
        }, { condition = in_mathzone }),
        
        -- TODO: Make more generalized
        -- LaTeX: Brace-delimited fractions pt. 1
        s({ trig = "(\\frac%b{}%b{})/", regTrig = true, wordTrig = false }, {
            d(1, function(_, snip)
                return sn(
                    1,
                    fmt(
                        [[
                    \frac{{{}}}{{{}}}
                ]],
                        {
                            t(snip.captures[1]),
                            i(1),
                        }
                    )
                )
            end, {}),
        }, { condition = in_mathzone }),
        -- LaTeX: Brace-delimited fractions pt. 2
        s({ trig = "(\\%a+%b{})/", regTrig = true, wordTrig = false }, {
            d(1, function(_, snip)
                return sn(
                    1,
                    fmt(
                        [[
                    \frac{{{}}}{{{}}}
                ]],
                        {
                            t(snip.captures[1]),
                            i(1),
                        }
                    )
                )
            end, {}),
        }, { condition = in_mathzone }),
        
        -- LaTeX: Regexp fractions
        s({ trig = "([%a%d^_\\!'.]+)/", regTrig = true, wordTrig = false }, {
            d(1, function(_, snip)
                return sn(1, {
                    t("\\frac{"),
                    t(snip.captures[1]),
                    t("}{"),
                    i(1),
                    t("}"),
                })
            end, {}),
        }, { condition = in_mathzone }),

        -- LaTeX: Visual fractions: what is this?
        s("/", {
            d(1, function(_, snip)
                if snip.env.TM_SELECTED_TEXT[1] then
                    return sn(1, {
                        t("\\frac{" .. snip.env.TM_SELECTED_TEXT[1] .. "}{"),
                        i(1),
                        t("}"),
                    })
                end
                return sn(nil, t("/"))
            end),
        }, { condition = in_mathzone }),
        
        -- LaTeX: Binary operator dots
        s("...", t("\\dots"), { condition = in_mathzone }),
        s(".b", t("\\dotsb"), { condition = in_mathzone }),
        s(".c", t("\\dotsc"), { condition = in_mathzone }),

        -- LaTeX: common operations ( may need to install packages )
        s({ trig = "in", regTrig = true }, {
            t"\\in"
        }, {condition = in_mathzone}),
        s({ trig = "inf", regTrig = true }, {
            t"infty"
        }, {condition = in_mathzone}),
        s({ trig = "EE", wordTrig = false }, {
            t "\\mathbf{E}[" , i(1), t"] ", i(2),
        }, { condition = in_mathzone }),
        s({ trig = "PP", wordTrig = false }, {
            t "\\mathbf{P}(", i(1), t") ", i(2),
        }, { condition = in_mathzone }),
        s({ trig = "sqrt" }, {
            t("\\sqrt{"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),
        s({ trig = "paren", wordTrig = false }, {
            t("\\paren{"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),
        s({ trig = "vec", wordTrig = false }, {
            t("\\vec{"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),
        s({ trig = "set", wordTrig = false }, {
            t("\\set{"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),
        s({ trig = "tup", wordTrig = false }, {
            t("\\tup{"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),
        s({ trig = "norm", wordTrig = false }, {
            t("\\norm{"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),
        s({ trig = "abs", wordTrig = false }, {
            t("\\abs{"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),
        s({ trig = "braket", wordTrig = false }, {
            t("\\braket{"),
            i(1),
            t("}{"),
            i(2),
            t("}"),
        }, { condition = in_mathzone }),
        s({ trig = "ket", wordTrig = false }, {
            t("\\ket{"),
            i(1),
            t("}"),
        }, { condition = in_mathzone }),

        -- underlining
        s({ trig = "uu" }, { t("\\underline{"), i(1), t"}", i(0) }, { condition = in_mathzone }),

        -- indicator
        s({ trig = "II" }, t"\\mathbbm{1}" , { condition = in_mathzone }),

        s({ trig = "hh" }, { t"\\hat{", i(1), t"}" }, { condition = in_mathzone }),

        s({ trig = "log" }, { t("\\log"), }, { condition = in_mathzone }),
        s({ trig = "ln" }, { t("\\ln"), }, { condition = in_mathzone }),
        s({ trig = "exp" }, { t("\\exp"), }, { condition = in_mathzone }),

        s({ trig = "ll" }, { t("\\left"), }, { condition = in_mathzone }),
        s({ trig = "rr" }, { t("\\right"), }, { condition = in_mathzone }),
        s({ trig = "lr(" }, { t("\\left( "), i(1), t" \\right", }, { condition = in_mathzone }),
        s({ trig = "lr[" }, { t("\\left[ "), i(1), t" \\right", }, { condition = in_mathzone }),
        s({ trig = "lr{" }, { t("\\left\\{ "), i(1), t" \\right\\}", }, { condition = in_mathzone }),

        -- LaTeX: Auto-aligned equals
        -- s(
        --     { trig = "([^&])=", regTrig = true, wordTrig = false },
        --     f(function(_, snip)
        --         return snip.captures[1] .. "&="
        --     end),
        --     { condition =  in_align }
        -- ),
        

        -- integrals
        s( { trig = "\\int"  },
                    fmt(
                        [[
                    \int_{{{}}}^{{{}}}
                ]],
                        {
                            i(1, "\\infty"),
                            i(2, "\\infty"),
                        }
                    ),
            { condition = in_mathzone }
        ),
        
        -- LaTeX: Summations
        s(
            { trig = "([^\\])sum", regTrig = true },
            d(1, function(_, snip)
                return sn(
                    1,
                    fmt(
                        [[
                    {}\sum_{{{}={}}}^{{{}}}
                ]],
                        {
                            t(snip.captures[1]),
                            i(1, "i"),
                            i(2, "1"),
                            i(3, "\\infty"),
                        }
                    )
                )
            end),
            { condition = in_mathzone }
        ),
        s(
            { trig = "([^\\])prod", regTrig = true },
            d(1, function(_, snip)
                return sn(
                    1,
                    fmt(
                        [[
                    {}\prod_{{{}={}}}^{{{}}}
                ]],
                        {
                            t(snip.captures[1]),
                            i(1, "i"),
                            i(2, "1"),
                            i(3, "\\infty"),
                        }
                    )
                )
            end),
            { condition = in_mathzone }
        ),
        -- LaTeX: Limits
        s(
            { trig = "([^\\])lim", regTrig = true },
            d(1, function(_, snip)
                return sn(
                    1,
                    fmt(
                        [[
                    {}\lim_{{{}\to {}}}
                ]],
                        {
                            t(snip.captures[1]),
                            i(1, "n"),
                            i(2, "\\infty"),
                        }
                    )
                )
            end),
            { condition = in_mathzone }
        ),
        -- LaTeX: Functions
        s({ trig = "(%a):", regTrig = true, wordTrig = false }, {
            d(1, function(_, snip)
                return sn(1, {
                    t(snip.captures[1] .. "\\colon "),
                    i(1, "\\R"),
                    t("\\to "),
                    i(2, "\\R"),
                })
            end),
        }, { condition = in_mathzone }),

        s({ trig = "=>", wordTrig=true}, t "\\implies", {condition = in_mathzone }),
        s({ trig = "->", wordTrig=true}, t "\\xrightarrow", {condition = in_mathzone }),

        -- could be improved by not first matching the space
        -- s({ trig = " (%a%a%a%a+) ", regTrig = true, wordTrig = false},
        --     f( function (_, snip)
        --         return "\\text{" .. snip.captures[1] .. "}"
        --     end), 
        --     {condition = in_mathzone }),
        -- End Snippets --
    }
