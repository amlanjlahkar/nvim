local M = {
  "lewis6991/gitsigns.nvim",
  lazy = false,
}

function M.opts()
  local key = require("core.keymap.maputil")
  local cmd, opts, expr = key.cmd, key.new_opts, key.expr

  return {
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
      { "<leader>gv", gs.select_hunk, opts("Gitsigns: stage hunk") },
      { "<leader>gd", gs.diffthis, opts("Gitsigns: diff file with current index") },
    })
    key.xmap({
      { "<leader>gr", ":Gitsigns reset_hunk<CR>", opts("Gitsigns: reset hunk") },
      { "<leader>gs", ":Gitsigns stage_hunk<CR>", opts("Gitsigns: stage hunk") },
    })
      -- stylua: ignore end
    end,
  }
end

return M
