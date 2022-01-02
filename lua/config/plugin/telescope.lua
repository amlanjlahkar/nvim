require('telescope').setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}
require('telescope').load_extension('fzy_native')
-- keymaps
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<C-f>', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
map('n', '<C-b>', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
map('n', '<leader>th', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)
map('n', '<leader>tg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)

local status_ok, harpoon = pcall(require, "harpoon")
if status_ok then
    require("telescope").load_extension('harpoon')
    map('n', '<leader>tm', '<cmd>Telescope harpoon marks<cr>', opts)
else
    return
end

