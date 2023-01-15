-- Not needed
--local ok, nerdtree = pcall(require, "nerdtree")
--if not ok then
--    print("Failed to load nerdtree.lua")
--    return
--end

vim.api.nvim_set_keymap("n", "<leader>nn", ":NERDTreeToggle<CR>", {})
