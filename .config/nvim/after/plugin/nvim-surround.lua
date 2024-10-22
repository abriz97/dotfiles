local status_ok, configs = pcall(require, "nvim-surround")
if not status_ok then
    print("Failed to load nvim-surround.lua")
    return
end

configs.setup({
})
