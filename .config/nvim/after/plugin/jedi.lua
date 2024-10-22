local ok, jedi = pcall(require, "jedi")
if not ok then
    print("Failed to load jedi.lua")
    return
end

-- local gjedi = vim.g.jedi
-- 
-- gjedi.environment_path="/bin/python3.10"
-- gjedi.goto_command = "<leader>d"
-- gjedi.goto_assignments_command = "<leader>g"
-- gjedi.goto_stubs_command = "<leader>s"
-- gjedi.goto_definitions_command = ""
-- gjedi.documentation_command = "K"
-- gjedi.usages_command = "<leader>n"
-- gjedi.completions_command = "<C-Space>"
-- gjedi.rename_command = "<leader>r"
