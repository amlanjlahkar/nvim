-- leader key
vim.g.mapleader = " "

local key = require("core.keymap.maputil")
local cmd, opts = key.cmd, key.new_opts

key.nmap({
  -- handling buffers and windows {{{
  { "<leader>.", cmd("bn"), opts("Next buffer") },
  { "<leader>,", cmd("bp"), opts("Previous buffer") },
  { "<leader>bd", cmd("bd"), opts("Delete current buffer") },
  { "<leader>bD", cmd("%bd|e#|bd#|normal `"), opts("Delete all except current buffer") },
  { "<leader><Right>", cmd("vertical resize +7"), opts("Resize pane towards right") },
  { "<leader><Left>", cmd("vertical resize -7"), opts("Resize pane towards left") },
  { "<leader><Down>", cmd("resize +7"), opts("Resize pane towards down") },
  { "<leader><Up>", cmd("resize -7"), opts("Resize pane towards up") },
  -- }}}

  -- terminal related {{{
  { "<leader><leader>t", cmd("tabnew term://bash"), opts("Open terminal") },
  -- }}}

  -- movements and editing {{{
  { "<leader>j", "<cmd>m .+1<CR>==", opts("Move current line down") },
  { "<leader>k", "<cmd>m .-2<CR>==", opts("Move current line up") },
  { "n", "nzzzv" },
  { "N", "Nzzzv" },
  { "]q", cmd("cnext") },
  { "[q", cmd("cprev") },
  { "<C-c>", cmd("cclose") },
  { ",", "@@" },
  -- }}}

  -- external {{{
  { "<leader>v", cmd("tab Git"), opts("Open vcs interface") },
  -- }}}

  -- misc {{{
  { "<F11>", cmd("setlocal spell!") },
  { "<F11>", cmd("<C-o>:setlocal spell!<CR>") },
  { "<F2>", cmd("!$BROWSER %") },
  { "<leader><leader>s", cmd("silent :write | source %"), opts("Save and source lua file") },
  -- }}}
})
