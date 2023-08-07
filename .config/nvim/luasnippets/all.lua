---@diagnostic disable: undefined-global

return {
    -- All: Prints the current date in Y-m-d format
    s(
        "date",
        f(function()
            return os.date("%Y-%m-%d")
        end)
    ),

    s( "phonenumber", t "+44 (0)7546528723"), 
    s( "email-ic", t "ab1820@ic.ac.uk"), 
    s( "email-hm", t "andreabrizzi@live.it"), 


    -- Common long file paths
    -- s('DEEPANALYSES', t'/home/andrea/Documents/Box/ratmann_deepseq_analyses/live'),
    -- s('XIAOYUE', t'/home/andrea/Documents/Box/ratmann_xiaoyue_jrssc2022_analyses/live'),
    -- s('DEEPDATA', t'/home/andrea/Documents/Box/ratmann_pangea_deepsequencedata'),
    s('DEEPANALYSES', t'/home/andrea/HPC/project/ratmann_deepseq_analyses/live'),
    s('XIAOYUE', t'/home/andrea/HPC/project/ratmann_xiaoyue_jrssc2022_analyses/live'),
    s('DEEPDATA', t'/home/andrea/HPC/project/ratmann_pangea_deepsequencedata/live'),
    s('SOFTWARE', t'/home/andrea/git/Phyloscanner.R.utilities/misc_data_analysis_RCCS1519/software'),
    s('FLOWS', t'/home/andrea/git/phyloflows'),
    s('SUBMISSION', t'/home/andrea/Documents/P1Brazil/submission/naturemed_v3'),
    s('MARKING', t'/home/andrea/Documents/marking'),
    s('EXTERNAL', t'/media/andrea/SSD/'),

    -- End Snippets --
}, {
    s( "b4", t "before"),
    s( "btwn", t "between"),
    s( "wrt", t "with respect to"),

    s( "HIV+", t "HIV positive"),
    s( "HIV-", t "HIV negative"),

    -- common typos:
    s( "lenght", t"length"),
    s( "widht", t"width")

}
