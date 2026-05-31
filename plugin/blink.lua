local opts = {
    completion = {
        menu = {
            scrollbar = false,
            draw = {
                columns = { { 'label', 'label_description' }, { 'kind' }, { 'source_name' } },
                treesitter = { 'lsp' },
            },
        },
        documentation = {
            auto_show = true,
            window = { scrollbar = false },
        },
        list = { selection = { preselect = false } },
    },
    cmdline = { enabled = false },
    keymap = {
        preset = 'default',
        ['<C-l>'] = { 'select_and_accept' },
        ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
    },
}

vim.api.nvim_create_autocmd('InsertEnter', {
    once = true,
    callback = function()
        vim.pack.add({
            { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.10.x') },
        })

        require('blink.cmp').setup(opts)
    end,
})
