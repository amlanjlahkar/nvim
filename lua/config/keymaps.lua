local gvar = vim.g
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- leader key
gvar.mapleader = ' '

-- handling buffers {{{
map("n", "<leader>bn", "<cmd>bn<CR>", opts)
map("n", "<leader>bp", "<cmd>bp<CR>", opts)
map("n", "<leader>bd", "<cmd>bd<CR>", opts)
map("n", "<leader>bu", "<cmd>bunload<CR>", opts)
map("n", "<leader>db", "<cmd>%bd|e#|bd#|normal `<CR>", opts)
--- }}}

-- terminal related {{{
vim.cmd "autocmd termopen * startinsert"
map("n", "<leader>tn", "<cmd>new term://zsh<CR>", opts)
-- }}}

-- movements {{{
map("n", "<leader>j", "<cmd>m .+1<CR>==", opts)
map("n", "<leader>k", "<cmd>m .-2<CR>==", opts)
map("v", "J", "<cmd>m '>+1<CR>gv=gv", opts)
map("v", "K", "<cmd>m '<-2<CR>gv=gv", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
-- }}}

-- misc {{{
map("n", "<leader>e", "<cmd>Lexplore<CR>", opts)

map("n", "<leader><Right>", "<cmd>vertical resize +7<CR>", opts)
map("n", "<leader><Left>", "<cmd>vertical resize -7<CR>", opts)
map("n", "<leader><Down>", "<cmd>resize +7<CR>", opts)
map("n", "<leader><Up>", "<cmd>resize -7<CR>", opts)

map("n", "<F11>", "<cmd>set spell!<CR>", opts)
map("i", "<F11>", "<C-o>:set spell!<CR>", opts)
-- }}}