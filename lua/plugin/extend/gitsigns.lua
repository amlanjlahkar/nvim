local is_available, gitsigns = pcall(require, "gitsigns")
if not is_available then
  return
end

local key = require("core.keymap.maputil")
local cmd, opts, expr = key.cmd, key.new_opts, key.expr

gitsigns.setup({
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
      { "<leader>gr", cmd("Gitsigns reset_hunk"), opts("Gitsigns: reset hunk") },
      { "<leader>gs", cmd("Gitsigns stage_hunk"), opts("Gitsigns: stage hunk") },
    })
    key.xmap({
      { "<leader>gr", cmd("Gitsigns reset_hunk"), opts("Gitsigns: reset hunk") },
      { "<leader>gs", cmd("Gitsigns stage_hunk"), opts("Gitsigns: stage hunk") },
    })
    -- stylua: ignore end
  end,
})
