local group = vim.api.nvim_create_augroup("Filetypes", {clear=true})
local ft_autocmd = function(pattern, cmd)
    vim.api.nvim_create_autocmd(
        {"BufRead", "BufNewFile", "BufFilePre"},{
            pattern= pattern,
            command = cmd,
            group=group
        } 
)
end

ft_autocmd("*stan", 'stan')
ft_autocmd("*rmd,*Rmd", 'rmd')
