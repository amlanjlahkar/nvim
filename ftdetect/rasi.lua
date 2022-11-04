vim.api.nvim_create_autocmd( { "BufNewFile", "BufRead" }, {
  group = vim.api.nvim_create_augroup("_ftdetect", { clear = true }),
  pattern = "*.rasi",
  callback = function()
    vim.opt_local.filetype = "css"
  end
})
