local api = vim.api

local function draw_virtline()
    return vim.v.virtnum < 1 and "%s" or ""
end

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    desc = "Set statuscolumn",
    group = api.nvim_create_augroup("_stc", { clear = true }),
    callback = function()
        local o = vim.opt_local
        if not vim.tbl_contains(api.nvim_get_mode(), { "t", "nt", "ntT", "r?", "!" }) and o.nu:get() then
            o.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} " .. draw_virtline()
        else
            o.statuscolumn = ""
        end
    end,
})
