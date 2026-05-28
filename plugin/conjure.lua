vim.api.nvim_create_autocmd('FileType', {
    once = true,
    pattern = { 'clojure' },
    callback = function (ev)
        vim.pack.add({ 'https://github.com/olical/conjure' })
    end
})
