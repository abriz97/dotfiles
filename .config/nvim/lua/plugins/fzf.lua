local function map(m, k, v)
    vla.keymap.set(m,k, v, { silent = true})
end

map(m, "<C-p>", ":Files<Cr>")
