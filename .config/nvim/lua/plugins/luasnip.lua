local ok, luasnip = pcall(require, "luasnip")
if not ok then
    print("Failed to load luasnip.vim")
    return
end

-- inspired by: https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L190
local ls = require("luasnip")
--
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

-- TODO: move to cmp config
vim.cmd([[

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

]])

-- jump to snippet creation
vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])
vim.keymap.set("n", "<Leader><CR>", "<cmd>LuaSnipEdit<CR>", { silent = true, noremap = true})
vim.cmd( [[ autocmd BufEnter */luasnippets/*lua nnoremap <silent> <buffer> <CR> /-- End Snippets --<CR>O<BS><BS><Esc>O<BS><BS>]] )


-- Every unspecified option will be set to the default.
ls.setup({
    history = true,
    -- Update more often, :h events for more info.
    update_events = "TextChanged,TextChangedI",
    -- Snippets aren't automatically removed if their text is deleted.
    -- `delete_check_events` determines on which events (:h events) a check for
    -- deleted snippets is performed.
    -- This can be especially useful when `history` is enabled.
    delete_check_events = "TextChanged",
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "choiceNode", "Comment" } },
            },
        },
    },
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 300,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    enable_autosnippets = true,
    -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
    -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
    store_selection_keys = "<Tab>",
    ft_func = require("luasnip.extras.filetype_functions").from_cursor,
})

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
    return args[1]
end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls
rec_ls = function()
    return sn(
        nil,
        c(1, {
            -- Order is important, sn(...) first would cause infinite loop of expansion.
            t(""),
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
        })
    )
end

-- complicated function for dynamicNode.
local function jdocsnip(args, _, old_state)
    -- !!! old_state is used to preserve user-input here. DON'T DO IT THAT WAY!
    -- Using a restoreNode instead is much easier.
    -- View this only as an example on how old_state functions.
    local nodes = {
        t({ "/**", " * " }),
        i(1, "A short Description"),
        t({ "", "" }),
    }
    
    -- These will be merged with the snippet; that way, should the snippet be updated,
    -- some user input eg. text can be referred to in the new snippet.
    local param_nodes = {}
    
    if old_state then
        nodes[2] = i(1, old_state.descr:get_text())
    end
    param_nodes.descr = nodes[2]
    
    -- At least one param.
    if string.find(args[2][1], ", ") then
        vim.list_extend(nodes, { t({ " * ", "" }) })
    end
    
    local insert = 2
    for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
        -- Get actual name parameter.
        arg = vim.split(arg, " ", true)[2]
        if arg then
            local inode
            -- if there was some text in this parameter, use it as static_text for this new snippet.
            if old_state and old_state[arg] then
                inode = i(insert, old_state["arg" .. arg]:get_text())
            else
                inode = i(insert)
            end
            vim.list_extend(
                nodes,
                { t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) }
            )
            param_nodes["arg" .. arg] = inode
            insert = insert + 1
        end
    end
    
    if args[1][1] ~= "void" then
        local inode
        if old_state and old_state.ret then
            inode = i(insert, old_state.ret:get_text())
        else
            inode = i(insert)
        end
        
        vim.list_extend(
            nodes,
            { t({ " * ", " * @return " }), inode, t({ "", "" }) }
        )
        param_nodes.ret = inode
        insert = insert + 1
    end
    
    if vim.tbl_count(args[3]) ~= 1 then
        local exc = string.gsub(args[3][2], " throws ", "")
        local ins
        if old_state and old_state.ex then
            ins = i(insert, old_state.ex:get_text())
        else
            ins = i(insert)
        end
        vim.list_extend(
            nodes,
            { t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) }
        )
        param_nodes.ex = ins
        insert = insert + 1
    end
    
    vim.list_extend(nodes, { t({ " */" }) })
    
    local snip = sn(nil, nodes)
    -- Error on attempting overwrite.
    snip.old_state = param_nodes
    return snip
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
    local file = io.popen(command, "r")
    local res = {}
    for line in file:lines() do
        table.insert(res, line)
    end
    return res
end

-- Returns a snippet_node wrapped around an insertNode whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, snip, old_state, fmt)
    local fmt = fmt or "%Y-%m-%d"
    return sn(nil, i(1, os.date(fmt)))
end

-- snippets are added via ls.add_snippets(filetype, snippets[, opts]), where
-- opts may specify the `type` of the snippets ("snippets" or "autosnippets",
-- for snippets that should expand directly after the trigger is typed).
--
-- opts can also specify a key. By passing an unique key to each add_snippets, it's possible to reload snippets by
-- re-`:luafile`ing the file in which they are defined (eg. this one).


-- adapted from https://github.com/kylechui/config.nvim 

-- Loads in snippets
require("luasnip.loaders.from_lua").load({
    paths = vim.fn["stdpath"]("config") .. "/luasnippets/",
})


ls.add_snippets("all", {
    -- trigger is `fn`, second argument to snippet-constructor are the nodes to insert into the buffer on expansion.

    -- Parsing snippets: First parameter: Snippet-Trigger, Second: Snippet body.
    -- Placeholders are parsed into choices with 1. the placeholder text(as a snippet) and 2. an empty string.
    -- This means they are not SELECTed like in other editors/Snippet engines.
    ls.parser.parse_snippet(
        "lspsyn",
        "Wow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}"
    ),
    
    -- When wordTrig is set to false, snippets may also expand inside other words.
    ls.parser.parse_snippet(
        { trig = "te", wordTrig = false },
        "${1:cond} ? ${2:true} : ${3:false}"
    ),
    
    -- When regTrig is set, trig is treated like a pattern, this snippet will expand after any number.
    ls.parser.parse_snippet({ trig = "%d", regTrig = true }, "A Number!!"),
    -- Using the condition, it's possible to allow expansion only in specific cases.
    s("cond", {
        t("will only expand in c-style comments"),
    }, {
        condition = function(line_to_cursor, matched_trigger, captures)
            -- optional whitespace followed by //
            return line_to_cursor:match("%s*//")
        end,
    }),
    -- there's some built-in conditions in "luasnip.extras.conditions.expand" and "luasnip.extras.conditions.show".
    s("cond2", {
        t("will only expand at the beginning of the line"),
    }, {
        condition = conds_expand.line_begin,
    }),
    s("cond3", {
        t("will only expand at the end of the line"),
    }, {
        condition = conds_expand.line_end,
    }),
    -- The last entry of args passed to the user-function is the surrounding snippet.
    s(
        { trig = "a%d", regTrig = true },
        f(function(_, snip)
            return "Triggered with " .. snip.trigger .. "."
        end, {})
    ),
    -- It's possible to use capture-groups inside regex-triggers.
    s(
        { trig = "b(%d)", regTrig = true },
        f(function(_, snip)
            return "Captured Text: " .. snip.captures[1] .. "."
        end, {})
    ),
    s({ trig = "c(%d+)", regTrig = true }, {
        t("will only expand for even numbers"),
    }, {
        condition = function(line_to_cursor, matched_trigger, captures)
            return tonumber(captures[1]) % 2 == 0
        end,
    }),

    -- Use a function to execute any shell command and print its text.
    s("bash", f(bash, {}, { user_args = { "ls" } })),
    -- Short version for applying String transformations using function nodes.
    s("transform", {
        i(1, "initial text"),
        t({ "", "" }),
        -- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
        -- This list will be applied in order to the first node given in the second argument.
        l(l._1:match("[^i]*$"):gsub("i", "o"):gsub(" ", "_"):upper(), 1),
    }),
    s("transform2", {
        i(1, "initial text"),
        t("::"),
        i(2, "replacement for e"),
        t({ "", "" }),
        -- Lambdas can also apply transforms USING the text of other nodes:
        l(l._1:gsub("e", l._2), { 1, 2 }),
    }),
    s({ trig = "trafo(%d+)", regTrig = true }, {
        -- env-variables and captures can also be used:
        l(l.CAPTURE1:gsub("1", l.TM_FILENAME), {}),
    }),
    -- The nonempty-node inserts text depending on whether the arg-node is
    -- empty.

    -- s("nempty", {
    --     i(1, "sample_text"),
    --     n(1, "i(1) is not empty!"),
    -- }),

    -- dynamic lambdas work exactly like regular lambdas, except that they
    -- don't return a textNode, but a dynamicNode containing one insertNode.
    -- This makes it easier to dynamically set preset-text for insertNodes. 
    s("dl1", {
        i(1, "sample_text"),
        t({ ":", "" }),
        dl(2, l._1, 1),
    }),
}, {
    key = "all",
})

ls.add_snippets("tex", {
    -- rec_ls is self-referencing. That makes this snippet 'infinite' eg. have as many
    -- -- \item as necessary by utilizing a choiceNode.
    s("ls", {
        t({ "\\begin{itemize}", "\t\\item " }),
        i(1),
        d(2, rec_ls, {}),
        t({ "", "\\end{itemize}" }),
    }),
}, {
        type = "autosnippets",
        key = "tex",
})

-- set type to "autosnippets" for adding autotriggered snippets.
ls.add_snippets("all", {
    s("autotrigger", {
        t("autosnippet"),
    }),
}, {
    type = "autosnippets",
    key = "all_auto",
})

-- in a lua file: search lua-, then c-, then all-snippets.
ls.filetype_extend("lua", { "c" })
-- in a cpp file: search c-snippets, then all-snippets only (no cpp-snippets!!).
ls.filetype_set("cpp", { "c" })

-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.

require("luasnip.loaders.from_vscode").load({ include = { "python" } }) -- Load only python snippets

-- The directories will have to be structured like eg. <https://github.com/rafamadriz/friendly-snippets> (include
-- a similar `package.json`)
require("luasnip.loaders.from_vscode").load({ paths = { "./my-snippets" } }) -- Load snippets from my-snippets folder

-- You can also use lazy loading so snippets are loaded on-demand, not all at once (may interfere with lazy-loading luasnip itself).
require("luasnip.loaders.from_vscode").lazy_load() -- You can pass { paths = "./my-snippets/"} as well

require("luasnip.loaders.from_snipmate").load({ include = { "c" } }) -- Load only snippets for c.

require("luasnip.loaders.from_snipmate").lazy_load() -- Lazy loading

-- see DOC.md/LUA SNIPPETS LOADER for some details.
require("luasnip.loaders.from_lua").load({ include = { "c" } })
require("luasnip.loaders.from_lua").lazy_load({ include = { "all", "cpp" } })


-- Adds a new command to reload snippets
vim.api.nvim_create_user_command("ReloadSnippets", function()
    require("luasnip.loaders.from_lua").load({
        paths = vim.fn["stdpath"]("config") .. "/luasnippets/",
    })
end, {})
