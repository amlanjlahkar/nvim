local api = vim.api
local au = api.nvim_create_autocmd

local parsers = {
    'bash',
    'typst',
    'gleam',
    'jsonnet',
    'svelte',
    'html',
    'css',
    'javascript',
}

return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',

        config = function()
            local ts = require('nvim-treesitter')

            ts.install(parsers)

            -- Include filetypes for builtin parsers
            local ts_parser_ft = vim.list_extend(parsers, { 'c', 'help', 'lua', 'markdown' })

            local ag_ts = api.nvim_create_augroup('treesitter', { clear = true })

            au('FileType', {
                desc = 'Use treesitter provided highligting, indenting and folding',
                group = ag_ts,
                pattern = ts_parser_ft,
                callback = function()
                    vim.treesitter.start()

                    local winid = vim.api.nvim_get_current_win()
                    vim.wo[winid].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    -- vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            au('BufWinEnter', {
                desc = 'Open all folds if using treesitter based folding upon displaying a buffer',
                group = ag_ts,
                callback = function()
                    if
                        vim.opt.foldmethod:get() == 'expr'
                        and vim.opt.foldexpr:get() == 'v:lua.vim.treesitter.foldexpr()'
                    then
                        vim.cmd.normal('zR')
                    end
                end,
            })
        end,
    },

    {
        'windwp/nvim-ts-autotag',
        ft = { 'html', 'svelte' },
        opts = {},
    },
}
