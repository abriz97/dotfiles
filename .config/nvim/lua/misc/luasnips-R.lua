-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders 
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

-- https://www.youtube.com/watch?v=ub0REXjhpmk&ab_channel=ziontee113-Healthy-Director-702
-- snippets are composed by different building bricks called nodes:
-- 0.  static text   t
-- 0b. functionNode  f
-- 1.  insertNode    i
-- 2.  choiceNode    c
-- 3.  dynamicNode   d
-- 4.  restoreNode   r
-- 5.  snippetNode   sn

-- VS code like snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- new line + tab
local nlt = t({"", "\t"})

-- Common long file paths
allsnips = { s('DEEPANALYSES', t'/home/andrea/Documents/Box/ratmann_deepseq_analyses/live'),
    s('DEEPANALYSES2', t'/home/andrea/HPC/project/ratmann_deepseq_analyses/live'),
    s('XIAOYUE', t'/home/andrea/Documents/Box/ratmann_xiaoyue_jrssc2022_analyses/live'),
    s('XIAOYUE2', t'/home/andrea/HPC/project/ratmann_xiaoyue_jrssc2022_analyses/live'),
    s('DEEPDATA', t'/home/andrea/Documents/Box/ratmann_pangea_deepsequencedata'),
    s('DEEPDATA2', t'/home/andrea/HPC/project/ratmann_pangea_deepsequencedata/live'),
    s('SOFTWARE', t'/home/andrea/git/Phyloscanner.R.utilities/misc_data_analysis_RCCS1519/software'),
    s('FLOWS', t'/home/andrea/git/phyloflows'),
    s('SUBMISSION', t'/home/andrea/Documents/P1Brazil/submission/naturemed_v3'),
    s('MARKING', t'/home/andrea/Documents/marking'),
    s('EXTERNAL', t'/media/andrea/SSD/'),
}

luasnips = {

    s(';s', { t"s(", i(1), t", {", i(2), t"})"  }),
    s(';t', { t"t('", i(1), t"')" }),
    s(';i', { t"i(", i(1), t")" }),
    s(';c', { t"c(", i(1), t", {", i(2), t"})"  }),
    s(';fmt', {t"fmt(", nlt, t"[[", nlt, i(1), nlt, t{"]]",",{"}, nlt, i(2), nlt, t"}", t")", })
}

stansnips = {

    -- TODO: loops, functions, and maybe body! 
-- autocmd  inoremap ;fun type<space>(<>)((<>))<space>{<return>}<Esc>k0w
-- autocmd  inoremap ;for for<space>(X<space>in<space>(<>))<space>{<return>}<Esc>k0fXcl
    s(';ii', { t("int "), i(1, 'i'), t(";")}),
    s(';rr', { t("real "), i(1, 'r'), t(";")}),
    s(';vv', { t("vector["), i(1, 'type'), t('] '), i(2,'v'), t(';') }),
    s(';rv', { t("rowvector["), i(1,''), t("] "), i(2,'')}), 
    s(';aa', { t("array[]"), i(1,'')}),
    -- s(';m', t("matrix[", i(''), t(","), i(''), t("]"), i('')),
    s(';ll', t("lower=")),
    s(';uu', t("upper=")),
}


wikisnips = {
    s('=', 
        fmt([[
        = {} =

        {}
        ]], {
            i(1, 'TITLE'), i(2, 'Text here...')
        })
    ),

    s('==', 
        fmt([[
        == {} ==

        {}
        ]], {
            i(1, 'TITLE'), i(2, 'Text here...')
        })
    ),

    s('===', 
        fmt([[
        === {} ===

        {}
        ]], {
            i(1, 'TITLE'), i(2, 'Text here...')
        })
    ),
}

-- also think about the hidden = true options to remove the options from the cmp
ls.add_snippets('lua', luasnips, { type = 'autosnippets', key = 'lua'})
ls.add_snippets('r', rsnips, { type = 'autosnippets', key = 'r'})
ls.add_snippets('stan', stansnips, { type = 'autosnippets', key = 'stan'})
ls.add_snippets('vimwiki', wikisnips)
ls.add_snippets('all', allsnips)
