local api = vim.api

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  desc = "Set statuscolumn",
  group = api.nvim_create_augroup("_ext_statusCol", { clear = true }),
  callback = function()
    local o = vim.opt_local
    if o.nu:get() then
      o.statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum} %#StatusColSep#▐%#Normal#  "
    else
      o.statuscolumn = ""
    end
  end,
})
