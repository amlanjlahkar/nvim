return {
    'saghen/blink.cmp',
    version = 'v1.*',
    event = 'InsertEnter',
    opts = {
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
    },
}
