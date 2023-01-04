vim.g['lightline'] = {
        colorscheme = 'nightfly',
        active = {
                left = {{'mode', 'paste'}, {'readonly', 'filename', 'modified'}}
        },
        tabline = {
                left = {{ 'buffers' }},
                right = {{ 'close' }}
        },
        component_expand = { buffers ='lightline#bufferline#buffers'},
        component_type = { buffers = 'tabsel'}
}
