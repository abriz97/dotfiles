function ColorMyPencils(color)
    color = color or "catpuccin-macchiato"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- vim.api.nvim_create_autocmd("ColorScheme", {
--     pattern = "*",
--     callback = function()
--         package.loaded["feline"] = nil
--         package.loaded["catppuccin.groups.integrations.feline"] = nil
--         require("feline").setup {
--             components = require("catppuccin.groups.integrations.feline").get(),
--         }
--     end,
-- })

-- -- setup default colorscheme
vim.cmd.colorscheme "gruvbox-material"

-- -- ColorMyPencils()

