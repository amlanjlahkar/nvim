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
  { "<leader>a", "VGogg", opts("Select buffer content") },
  { "L", "$" },
  { "H", "_" },
  { "n", "nzzzv" },
  { "N", "Nzzzv" },
  { "J", "mzJ`z" },
  { "]q", cmd("cnext") },
  { "[q", cmd("cprev") },
  { "<C-c>", cmd("cclose") },
  -- { ",", "@@" },
  -- }}}

  -- external {{{
  { "<leader>v", cmd("tab Git"), opts("Open vcs interface") },
  { "<leader>ld", cmd("TroubleToggle document_diagnostics"), opts("Trouble: List document diagnostics") },
  { "<leader>f", function() require("plugin.null-ls").format() end,  opts("Lsp/Null-ls: Format buffer") },
  -- }}}

  -- misc {{{
  { "<F11>", cmd("setlocal spell!") },
  { "<F2>", cmd("!$BROWSER %") },
  { "<leader><leader>s", cmd("silent :write | source %"), opts("Save and source lua file") },
  -- }}}
})

-- viusal mode specific
key.vmap({
  { "<", "<gv" },
  { ">", ">gv" },
  { "J", ":m '>+1<CR>gv=gv" },
  { "K", ":m '<-2<CR>gv=gv" },
})

-- manual use of clipboard register to yank and paste
key.nmap({
  { "<C-y>", '"+y$', opts("Yank(eol) to system clipboard") },
  { "<C-p>", '"+p', opts("Paste from system clipboard") },
})
key.xmap({ "<C-y>", '"+y', opts("Yank line to system clipboard") })
