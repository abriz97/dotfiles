---@diagnostic disable: undefined-global


local begins_line = function()
    local cur_line = vim.api.nvim_get_current_line()
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end


return {

 s({trig='headPBS', wordTrig = true}, 
        fmt([[{}]], {
            c(1, {
                t({
                    "#!/bin/sh",
                    "#PBS -l walltime=07:59:00",
                    "#PBS -l select=1:ncpus=1:mem=6gb",
                    "#PBS -j oe",
                    "",
                    "# (rapid)",
                }),
                t({
                    "#!/bin/sh",
                    "#PBS -l walltime=(0-7):59:00",
                    "#PBS -l select=1:ncpus=(1-256):mem=(1-920)gb",
                    "#PBS -j oe",
                    "",
                    "# (short8)",
                }),
                t({
                    "#!/bin/sh",
                    "#PBS -l walltime=(9-71):59:00",
                    "#PBS -l select=1:ncpus=(1-8):mem=(1-100)gb",
                    "#PBS -j oe",
                    "",
                    "# (throughput72)",
                }),
                t({
                    "#!/bin/sh",
                    "#PBS -l walltime=(0-71):59:00",
                    "#PBS -l select=(1-16):ncpus=(9-32):mem=(1-124)gb",
                    "#PBS -j oe",
                    "",
                    "# (general72)",
                }),
                t({
                    "#!/bin/sh",
                    "#PBS -l walltime=(9-71):59:00",
                    "#PBS -l select=1:ncpus=(9-127):mem=(1-920)gb",
                    "#PBS -j oe",
                    "",
                    "# (medium72)",
                }),
                t({
                    "#!/bin/sh",
                    "#PBS -l walltime=(9-71):59:00",
                    "#PBS -l select=1:ncpus=(128;:256):mem=(1-920)gb",
                    "#PBS -j oe",
                    "",
                    "# (large72)",
                }),
                t({
                    "#!/bin/sh",
                    "#PBS -l walltime=(0-71):59:00",
                    "#PBS -l select=1:ncpus=(1-256):mem=(921-40000)gb",
                    "#PBS -j oe",
                    "",
                    "# (largemem72)",
                }),
                t({
                    "#!/bin/sh",
                    "#PBS -l walltime=(0-23):59:00",
                    "#PBS -l select=(1-4):ncpus=(1-256):mem=(1-920)gb",
                    "#PBS -j oe",
                    "",
                    "# (gpu72)",
                }),
            })
        })
    ),


}, {

       s({trig='fn', wordTrig = true},
        fmt(
            [[
            function {} {{
                {}
            }}
            ]], {
                i(1, 'name'),
                i(2, '# Todo'),
            })
    ),

    s({trig='for', wordTrig = true}, 
        fmt(
            [[
            for {} in {}
            do
                {}
            done
            ]],{
                i(1, 'i'),
                i(2),
                i(3),
            }
        )
    ),

    s({trig='case', wordTrig = true}, 
        fmt(
            [[
            case {} in
                {})
                    {}
                ;;

                *)
                    {}
                ;;
            esac
            ]],{
                i(1, 'EXPRESSION'),
                i(2, 'PATTERN'),
                i(3, 'STATEMENT'),
                i(4, 'STATEMENT'),
            }
        ), {condition = begins_line }
    )

    -- End Snippets --
}

