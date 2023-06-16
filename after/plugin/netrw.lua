vim.g.netrw_banner = false
vim.g.netrw_keepdir = true
vim.g.netrw_winsize = 20

local function netrw_maps()
    local map = vim.keymap.set
    local opts = {
        buffer = 0,
        silent = true,
        remap = true,
    }
    map("n", "l", "<CR>", opts)
    map("n", "<TAB>", "mf", opts)
    map("n", "<S-TAB>", "mF", opts)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        netrw_maps()
    end,
})
