vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.json', '*.jsonc' },
    command = 'setl filetype=json',
})
