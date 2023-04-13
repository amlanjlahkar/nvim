vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.json",
  callback = function()
    vim.opt_local.filetype = "jsonc"
  end,
})
