vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.xhtml",
    callback = function()
        vim.opt_local.filetype = "html"
    end,
})
