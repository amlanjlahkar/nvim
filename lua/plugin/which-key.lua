local M = {
  "folke/which-key.nvim",
  enable = false,
}

function M.config()
  local margin = { 1, 0, 1, 0 }
  vim.api.nvim_create_autocmd({ "VimResized", "BufEnter" }, {
    desc = "Resize which key window based on nvim_window width",
    callback = function()
      local width = require("core.util").get_width()
      if width >= 160 then
        margin[2] = 100
      else
        margin[2] = 0
      end
    end,
  })

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
