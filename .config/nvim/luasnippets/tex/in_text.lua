---@diagnostic disable: undefined-global

local in_comment = function()
    return vim.fn["vimtex#syntax#in_comment"]() == 1
end

local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- TOFIX:

local in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

local in_itemize = function()
    return in_env('itemize')
end

local in_tikzpicture = function()
    return in_env('tikzpicture')
end

local in_text = function()
    return not in_mathzone() and not in_comment()
end

local begins_line = function()
    local cur_line = vim.api.nvim_get_current_line()
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end

return {
},
    {

    -- preamble: newcommand
    -- s({trig="comm", regTrig=true}, {
    --     fmt(1, {
    --         t("\\section{"),
    --         t("\\section*{"),
    --     }),
    --     i(0),
    --     t("}"),
    -- }, { condition = in_text and begins_line }),

    -- LaTeX: Sections
    s({trig="sec", regTrig=true}, {
        c(1, {
            t("\\section{"),
            t("\\section*{"),
        }),
        i(0),
        t("}"),
    }, { condition = in_text and begins_line }),
    s({trig="ssec", regTrig=true}, {
        c(1, {
            t("\\subsection{"),
            t("\\subsection*{"),
        }),
        i(0),
        t("}"),
    }, { condition = in_text and begins_line }),
    s({trig="^sssec", regTrig=true}, {
        c(1, {
            t("\\subsubsection{"),
            t("\\subsubsection*{"),
        }),
        i(0),
        t("}"),

    }, { condition = in_text and begins_line }),
        -- LaTeX: Inline math mode
        s("mm", fmt("${}$", i(1)), { condition = in_text }),
        -- LaTeX: Display math mode
        s("dm", {
            t({ "\\[", "\t" }),
            i(0),
            t({ "", "\\]" }),
        }, { condition = in_text }),
        -- LaTeX: Single-letter variables
        s(
            { trig = " ([b-zB-HJ-Z])([%p%s])", regTrig = true, wordTrig = false },
            f(function(_, snip)
                return " $" .. snip.captures[1] .. "$" .. snip.captures[2]
            end),
            { condition = in_text }
        ),
        -- LaTeX: Quotations
        s('"', fmt([[``{}'']], i(1)), { condition = in_text }),
        -- LaTeX: Emphasis
        s("emph", fmt([[\emph{{{}}}]], i(1)), { condition = in_text }),
        -- LaTeX: Boldface
        s("bf", fmt([[\textbf{{{}}}]], i(1)), { condition = in_text }),
        s("tit", fmt([[\textit{{{}}}]], i(1)), { condition = in_text }),
        s("uu", fmt([[\underline{{{}}}]], i(1)), { condition = in_text }),

        s("tcol", fmt([[\textcolor{{{}}}{{{}}}]], {i(1, 'red'), i(2)}), { condition = in_text }),
        -- LaTeX: Teletype
        s("tt", fmt([[\texttt{{{}}}]], i(1)), { condition = in_text }),
        -- LaTeX: Ordinal nth
        s({ trig = "([%d$])th", regTrig = true, wordTrig = false }, {
            f(function(_, snip)
                return snip.captures[1] .. "\\tsup{th}"
            end),
        }, { condition = in_text }),

        -- LaTeX: Image
        s("img", {
            t({ "\\begin{center}", "\t\\resizebox{" }),
            i(1, "5"),
            t("in}{!}{\\includegraphics{./"),
            i(2),
            t({ "}}", "\\end{center}" }),
        }, { condition = in_text }),
        
        -- LaTeX: Image
        s("img", {
            t({ "\\begin{center}", "\t\\resizebox{" }),
            i(1, "5"),
            t("in}{!}{\\includegraphics{./"),
            i(2),
            t({ "}}", "\\end{center}" }),
        }, { condition = in_text and begins_line}),


        -- Tikz
        s("tkz", fmt(
            [[
            \begin{{tikzpicture}}
                {}
            \end{{tikzpicture}}

            {}
            ]], {
                i(1),
                i(2, '(<>)')
            })
        , { condition = function(...) return begins_line(...) and (not in_tikzpicture(...)) end}),

        s("prm", t"parameter"),
        s("cts", t"continuous"),
        s("mvn", t"multivariate normal distribution"),
        s("fn", t"function"),
        s("ie", t"i.e.\\"),
        s("iid", t"i.i.d."),
        s(";rv", t"random variable"),
        s("ii", t{"","\\item "}, {condition=in_itemize}),
        --- End snippets
    }
