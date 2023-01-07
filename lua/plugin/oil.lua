local M = {
  "stevearc/oil.nvim",
  lazy = false,
}

function M.config()
  require("oil").setup({
    columns = { "permissions", "size", "mtime" },
    keymaps = {
      ["l"] = "actions.select",
      ["<C-x"] = "actions.select_split",
      ["<C-v"] = "actions.select_vsplit",
      ["gh"] = "actions.toggle_hidden",
    },
    win_options = {
      rnu = false,
      nu = false,
    },
  })

  vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
end

return M
