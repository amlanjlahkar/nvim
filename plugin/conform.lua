vim.pack.add({
    'https://github.com/stevearc/conform.nvim',
})

local util = require('conform.util')

require('conform').setup({
    formatters = {
        shfmt = {
            prepend_args = { '-i', '4', '-ci' },
        },
        ['blade-formatter'] = {
            command = util.from_node_modules('blade-formatter'),
        },
    },
    formatters_by_ft = {
        bash = { 'shfmt' },
        blade = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        json = { 'prettier', 'jq', stop_after_first = true },
        lua = { 'stylua' },
        php = { 'pint' },
        sh = { 'shfmt' },
        svelte = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
    },
    default_format_opts = {
        lsp_format = 'fallback',
    },
    log_level = vim.log.levels.DEBUG,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
    require('conform').format({ async = true }, function(err)
        if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), 'v') then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
            end
        end
    end)
end, { desc = 'Format buffer' })
