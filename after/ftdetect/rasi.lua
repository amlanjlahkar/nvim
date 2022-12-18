vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.rasi",
  callback = function()
    vim.opt_local.filetype = "rasi"
  end,
})
