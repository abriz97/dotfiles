local ok, fzf = pcall(require, "fzf")
if not ok then
    print("Failed to load fzf.lua")
    return
end

local function map(m, k, v)
    vla.keymap.set(m,k, v, { silent = true})
end

map(m, "<C-p>", ":Files<Cr>")
