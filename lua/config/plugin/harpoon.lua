local is_available, harpoon = pcall(require, "harpoon")
if not is_available then
    return
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

map('n', '<leader>hm', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)
map('n', '<leader>m', '<cmd>lua require("harpoon.mark").add_file()<cr>', opts)
map('n', '<leader>ma', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', opts)
map('n', '<leader>ms', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', opts)
map('n', '<leader>md', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', opts)
map('n', '<leader>mf', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', opts)
