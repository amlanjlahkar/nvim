local M = {
  "folke/which-key.nvim",
  lazy = false,
  enabled = false,
}

local margin = { 1, 0, 1, 0 }
vim.api.nvim_create_autocmd({ "VimResized", "BufEnter" }, {
  desc = "Resize which key window based on nvim_window width",
  callback = function()
    local width = require("core.util").get_width({ combined = false })
    if width >= 160 then
      margin[2] = 100
    else
      margin[2] = 0
    end
  end,
})

function M.config()
  require("which-key").setup({
    window = {
      border = "single",
      margin = margin,
      winblend = vim.opt.winblend:get(),
    },
    show_help = false,
    triggers = "<leader>",
  })
end

return M
