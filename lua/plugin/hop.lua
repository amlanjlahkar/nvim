local M = {
  "phaazon/hop.nvim",
  keys = { "<M-z>", { "<M-z>", mode = "x" } },
}

function M.config()
  local h = require("hop")
  h.setup()
  vim.keymap.set({ "n", "x" }, "<M-z>", function()
    h.hint_words({ multi_windows = true })
  end, { remap = false, silent = true })
end

return M
