return {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    version = 'v9.*',
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format({ async = true }, function(err)
                    if not err then
                        local mode = vim.api.nvim_get_mode().mode
                        if vim.startswith(string.lower(mode), 'v') then
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
                        end
                    end
                end)
            end,
            mode = { 'n', 'x' },
            desc = 'Format buffer',
        },
    },

    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,

    opts = {
        formatters = {
            shfmt = {
                prepend_args = { "-i", "4", "-ci" },
            },
        },
        formatters_by_ft = {
            css = { 'prettier' },
            html = { 'prettier' },
            javascript = { 'prettier' },
            javascriptreact = { 'prettier' },
            json = { 'prettier', 'jq', stop_after_first = true },
            lua = { 'stylua' },
            svelte = { 'prettier' },
            typescript = { 'prettier' },
            typescriptreact = { 'prettier' },
            bash = { 'shfmt' },
            sh = { 'shfmt' },
        },
        default_format_opts = {
            lsp_format = 'fallback',
        },
        log_level = vim.log.levels.DEBUG,
    },
}
