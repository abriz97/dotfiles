---@diagnostic disable: undefined-global

local begins_line = function()
    local cur_line = vim.api.nvim_get_current_line()
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end

return {
    
    -- End Snippets --
}, {

    s({ trig = "func", wordTrig = true }, {
        t({ "function()", "\t" }),
        i(0),
        t({ "", "end" }),
    }),


    s("fmt", fmt(
            [[
            s("{}", fmt(
                [%[
                {}
                ]%], {{
                {} 
                }}), {} 
            )
            ]], {
                i(1),
                i(2),
                i(3),
                i(4)
            }
        ) , {condition=begins_line})
}
