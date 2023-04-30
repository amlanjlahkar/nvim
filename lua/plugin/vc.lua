return {
  { "tpope/vim-fugitive", cmd = "Git" },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = function()
      local key = require("core.utils.map")
      local opts = key.new_opts

      return {
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          --stylua: ignore start
          key.nmap({
            { "]c", gs.next_hunk, opts(bufnr, "Gitsigns: next hunk") },
            { "[c", gs.prev_hunk, opts(bufnr, "Gitsigns: previous hunk") },
            { "<leader>gR", gs.reset_buffer, opts(bufnr, "Gitsigns: reset buffer") },
            { "<leader>gp", gs.preview_hunk, opts(bufnr, "Gitsigns: preview_hunk") },
            { "<leader>gr", gs.reset_hunk, opts(bufnr, "Gitsigns: reset hunk") },
            { "<leader>gs", gs.stage_hunk, opts(bufnr, "Gitsigns: stage hunk") },
            { "<leader>gv", gs.select_hunk, opts(bufnr, "Gitsigns: stage hunk") },
            { "<leader>gd", gs.diffthis, opts(bufnr, "Gitsigns: diff file with current index") },
          })
          key.xmap({
            { "<leader>gr", ":Gitsigns reset_hunk<CR>", opts(bufnr, "Gitsigns: reset hunk") },
            { "<leader>gs", ":Gitsigns stage_hunk<CR>", opts(bufnr, "Gitsigns: stage hunk") },
          })
          --stylua: ignore end
        end,
      }
    end,
  },
}
