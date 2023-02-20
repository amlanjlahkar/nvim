local M = {
  "lewis6991/gitsigns.nvim",
  lazy = false,
}

function M.config()
  local key = require("core.keymap.maputil")
  local cmd, opts, expr = key.cmd, key.new_opts, key.expr

  require("gitsigns").setup({
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

    -- stylua: ignore start
    key.nmap({
      {
        "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, opts(bufnr, expr, "Gitsigns: next hunk"),
      },
      {
        "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, opts(bufnr, expr, "Gitsigns: previous hunk"),
      },
      { "<leader>gR", gs.reset_buffer, opts("Gitsigns: reset buffer") },
      { "<leader>gp", gs.preview_hunk, opts("Gitsigns: preview_hunk") },
      { "<leader>gr", gs.reset_hunk, opts("Gitsigns: reset hunk") },
      { "<leader>gs", gs.stage_hunk, opts("Gitsigns: stage hunk") },
    })
    key.vmap({
      { "<leader>gr", gs.reset_hunk, opts("Gitsigns: reset hunk") },
      { "<leader>gs", gs.stage_hunk, opts("Gitsigns: stage hunk") },
    })
    -- stylua: ignore end
    end,
  })
end

return M
