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

rsnips = {

    s('ggplot', 
        fmt(
            [[
            ggplot({}, aes({})) +
                {} +
                facet_grid({}) +
                theme({}) +
                labs({})
            ]]
            ,{
                i(1, 'data'),
                i(2, 'aes'),
                i(3, 'geom_something()'),
                i(4, 'myGrid'),
                i(5, 'myTheme'),
                i(6, 'myLabs'),
            }
        )
    ),

    s('function',
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

    s('for', 
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

    s('if', 
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

    s('if-else', 
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

    s('by', { t('by = '), i(1, 'bycols') }),

    s('SD', { t('.SD = '), i(1, 'sdcols') }),

    s('dt', 
        fmt([[
        {}[ {}, {}, by='{}' ]
        ]], {
            i(1, 'Name'),
            i(2, 'cond'),
            i(4, 'action'),
            i(3, '')
        }
    )),

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

ls.add_snippets('vimwiki', wikisnips)
ls.add_snippets('r', rsnips)
