local map = vim.keymap.set
local function attrs(description)
  local opts = {
    silent = true,
    noremap = true,
    desc = description or {},
  }
  return opts
end

-- leader key
vim.g.mapleader = " "

-- handling buffers {{{
map("n", "<leader>.", "<cmd>bn<CR>", attrs("Next buffer"))
map("n", "<leader>,", "<cmd>bp<CR>", attrs("Previous buffer"))
map("n", "<leader>bd", "<cmd>bd<CR>", attrs("Delete current buffer"))
map("n", "<leader>bD", "<cmd>%bd|e#|bd#|normal `<CR>", attrs("Delete all except current buffer"))
-- }}}

-- terminal related {{{
map("n", "<leader><leader>t", "<cmd>vnew term://bash<CR>", attrs("Open terminal"))
-- }}}

-- movements {{{
map("n", "<leader>j", "<cmd>m .+1<CR>==", attrs("Move current line up"))
map("n", "<leader>k", "<cmd>m .-2<CR>==", attrs("Move current line down"))
map("n", "n", "nzzzv", attrs())
map("n", "N", "Nzzzv", attrs())
map("n", "]q", "<cmd>cnext<CR>", attrs())
map("n", "[q", "<cmd>cprev<CR>", attrs())
map("n", "<C-c>", "<cmd>cclose<CR>", attrs())
-- }}}

-- external {{{
map("n", "<leader>v", "<cmd>tab Git<CR>", attrs("Open vcs interface"))
-- }}}

-- misc {{{
-- map("n", "<leader>e", "<cmd>Lexplore<CR>", attrs())

map("n", "<leader><Right>", "<cmd>vertical resize +7<CR>", attrs("Resize pane towards right"))
map("n", "<leader><Left>", "<cmd>vertical resize -7<CR>", attrs("Resize pane towards left"))
map("n", "<leader><Down>", "<cmd>resize +7<CR>", attrs("Resize pane towards down"))
map("n", "<leader><Up>", "<cmd>resize -7<CR>", attrs("Resize pane towards up"))

map("n", "<F11>", "<cmd>setlocal spell!<CR>", attrs())
map("i", "<F11>", "<C-o>:setlocal spell!<CR>", attrs())

map("n", "<leader><leader>s", "<cmd>:write | source %<CR>", attrs("Save and source lua file"))

map("n", "<F2>", "<cmd>!$BROWSER %<CR>", attrs())
-- }}}
