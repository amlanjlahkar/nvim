local gvar = vim.g
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- leader key
gvar.mapleader = " "

-- handling buffers {{{
map("n", "<leader>.", "<cmd>bn<CR>", opts)
map("n", "<leader>,", "<cmd>bp<CR>", opts)
map("n", "<leader>bd", "<cmd>bd<CR>", opts)
map("n", "<leader>bu", "<cmd>bunload<CR>", opts)
map("n", "<leader>db", "<cmd>%bd|e#|bd#|normal `<CR>", opts)
--- }}}

-- terminal related {{{
vim.cmd "autocmd TermOpen * setlocal nonumber norelativenumber | startinsert"
map("n", "<leader><leader>t", "<cmd>vnew term://bash<CR>", opts)
map("n", "<leader>c", "<cmd>make %< <Bar> terminal ./%< <CR>", opts)
-- }}}

-- movements {{{
map("n", "<leader>j", "<cmd>m .+1<CR>==", opts)
map("n", "<leader>k", "<cmd>m .-2<CR>==", opts)
map("v", "J", "<cmd>m '>+1<CR>gv=gv", opts)
map("v", "K", "<cmd>m '<-2<CR>gv=gv", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "<C-j>", "<cmd>cnext<CR>", opts)
map("n", "<C-k>", "<cmd>cprev<CR>", opts)
map("n", "<C-c>", "<cmd>cclose<CR>", opts)
-- }}}

-- misc {{{
map("n", "<leader>e", "<cmd>Lexplore<CR>", opts)

map("n", "<leader><Right>", "<cmd>vertical resize +7<CR>", opts)
map("n", "<leader><Left>", "<cmd>vertical resize -7<CR>", opts)
map("n", "<leader><Down>", "<cmd>resize +7<CR>", opts)
map("n", "<leader><Up>", "<cmd>resize -7<CR>", opts)

map("n", "<F11>", "<cmd>set spell!<CR>", opts)
map("i", "<F11>", "<C-o>:set spell!<CR>", opts)

map("n", "<leader><leader>s", "<cmd>:write | source %<CR>", opts)
map("n", "<F2>", "<cmd>!$BROWSER %<CR>", opts)
map("n", "X", "r<space>", opts )
-- }}}
