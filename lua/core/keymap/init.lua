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
  { "J", "mzJ`z" },
  { "]q", cmd("cnext") },
  { "[q", cmd("cprev") },
  { "<C-k>", 'd$O<Esc>""p==j$' },
  { "<C-j>", 'd$o<Esc>""p==k$' },
  -- { ",", "@@" },
  -- }}}

  -- external {{{
  { "<leader><leader>v", cmd("tab Git"), opts("Open vcs interface") },
  {
    "<leader><leader>o",
    function()
      require("transparent").toggle_transparent()
    end,
    opts("Toggle transparency"),
  },
  -- }}}

  -- misc {{{
  { "<F10>", cmd("LspStart") },
  { "<F11>", cmd("setlocal spell!") },
  { "<F2>", cmd("!$BROWSER %") },
  { "<leader><leader>s", cmd("silent :write | source %"), opts("Save and source lua file") },
  {
    "<leader>d",
    function()
      local start = vim.api.nvim_get_current_buf()
      vim.cmd("vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis")
      local scratch = vim.api.nvim_get_current_buf()
      vim.cmd("wincmd p | diffthis")
      for _, buf in ipairs({ scratch, start }) do
        vim.keymap.set("n", "q", function()
          vim.api.nvim_buf_delete(scratch, { force = true })
          vim.keymap.del("n", "q", { buffer = start })
        end, { buffer = buf })
      end
    end,
    opts("Get relative diff for current file"),
  },
  -- }}}
})

-- viusal mode specific
key.vmap({
  { "<", "<gv" },
  { ">", ">gv" },
  { "J", ":m '>+1<CR>gv=gv" },
  { "K", ":m '<-2<CR>gv=gv" },
})

-- manual use of clipboard register
key.nmap({
  { "<leader>c", '"+y$', opts("Yank(eol) to system clipboard") },
  { "<leader>v", 'mc"+p`c==', opts("Paste from system clipboard") },
})
key.xmap({
  { "<leader>c", '"+y', opts("Yank to system clipboard") },
  { "<leader>v", '"+p==', opts("Paste from system clipboard") },
})
