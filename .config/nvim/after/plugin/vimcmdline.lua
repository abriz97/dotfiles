vim.cmd( [[

    let cmdline_app           = {}
    let cmdline_app['ruby']   = 'pry'
    let cmdline_app['sh']     = 'bash'
    let cmdline_app['python'] = 'python3.10'

    
    let cmdline_actions       = {}
    let cmdline_actions['python'] = {}
    let cmdline_actions['python']['<LocalLeader>pl']='locals()'
    let cmdline_actions['python']['<LocalLeader>pg']='globals()'
    let cmdline_actions['python']['<LocalLeader>pp']='print(%s)'
    let cmdline_actions['python']['<LocalLeader>pt']='type(%s)'
    let cmdline_actions['python']['<LocalLeader>pd']='dir(%s)'

    " vim.g.cmdline_actions = {
        " r = {
        " },
        " python = {
        "     {'<LocalLeader>l', 'locals()'},
        "     {'<LocalLeader>g', 'globals()'},
        "     {'<LocalLeader>p', 'print(%s)'},
        "     {'<LocalLeader>t', 'type(%s)'},
        "     {'<LocalLeader>d', 'dir(%s)'},
        " }
    "}

]] )
