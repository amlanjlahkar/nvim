local is_available, gitsigns = pcall(require, "gitsigns")
if not is_available then
  return
end

gitsigns.setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Gitsigns next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Gitsigns previous hunk" })

    map(
      { "n", "v" },
      "<leader>gr",
      ":Gitsigns reset_hunk<CR>",
      { silent = true, noremap = true, desc = "Gitsigns reset hunk" }
    )
    map("n", "<leader>gR", gs.reset_buffer, { silent = true, noremap = true, desc = "Gitsigns reset buffer" })
    map("n", "<leader>gp", gs.preview_hunk, { silent = true, noremap = true, desc = "Gitsigns preview diff" })
  end,
})
