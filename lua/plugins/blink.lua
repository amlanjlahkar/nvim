return {
    'saghen/blink.cmp',
    version = 'v1.*',
    event = 'InsertEnter',
    opts = {
        keymap = {
            preset = 'default',
            ['<C-s>'] = { 'show' },
            ['<C-l>'] = { 'select_and_accept' },
            ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
        },
        completion = {
            ghost_text = { enabled = false },
            completion = {
                list = { selection = { preselect = false, auto_insert = true } },
            },
            documentation = {
                auto_show = true,
                window = { border = 'single' },
            },
            menu = {
                auto_show = false,
                border = 'single',
                draw = {
                    treesitter = { 'lsp' },
                    columns = { { 'label', 'label_description' }, { 'kind' }, { 'source_name' } },
                },
            },
        },
        -- snippets = { preset = 'luasnip' },
        signature = {
            enabled = true,
            window = {
                border = 'single',
                winhighlight = 'Normal:NormalFLoat,FloatBorder:FloatBorder',
                show_documentation = false,
            },
        },
        cmdline = { enabled = false },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                buffer = {
                    opts = {
                        get_bufnrs = function()
                            return vim.tbl_filter(function(bufnr)
                                return vim.bo[bufnr].buftype == ''
                            end, vim.api.nvim_list_bufs())
                        end,
                    },
                },
            },
        },
    },
}
