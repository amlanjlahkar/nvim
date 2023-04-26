vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.conf",
  callback = function(self)
    local ft_def = { conf = "conf" }
    for ext, ft in pairs(ft_def) do
      if ext == vim.fn.fnamemodify(self.match, ":e") then
        vim.bo.ft = ft
        break
      end
    end
  end,
})
