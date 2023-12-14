local api = vim.api

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    desc = "Set statuscolumn",
    group = api.nvim_create_augroup("_core.extension", { clear = true }),
    callback = function()
        local o = vim.opt_local
        if not vim.tbl_contains(api.nvim_get_mode(), { "t", "nt", "ntT", "r?", "!" }) and o.nu:get() then
            o.statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum}%#Normal#  "
        else
            o.statuscolumn = ""
        end
    end,
})
