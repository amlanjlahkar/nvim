return {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format({ async = true })
            end,
            desc = 'Format buffer',
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { 'stylua' },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = 'fallback',
        },
        -- Customize formatters
        formatters = {},
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
