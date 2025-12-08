return {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {
        on_attach = function(bufnr)
            local gs = require('gitsigns')

            local keymap = require('utils.keymap')
            local mapopts = keymap.new_opts

            keymap.nmap({
                {
                    ']c',
                    function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gs.nav_hunk('next')
                        end
                    end,
                    mapopts(bufnr),
                },

                {
                    '[c',
                    function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gs.nav_hunk('prev')
                        end
                    end,
                    mapopts(bufnr),
                },

                -- stylua: ignore start
                { '<leader>ep', gs.preview_hunk, mapopts(bufnr) },
                { '<leader>ei', gs.preview_hunk_inline, mapopts(bufnr) },

                { '<leader>ec', gs.toggle_current_line_blame, mapopts(bufnr) },
                { '<leader>eb', function() gs.blame_line({ full = true }) end, mapopts(bufnr), },

                { '<leader>ed', gs.diffthis, mapopts(bufnr) },
                { '<leader>eD', function() gs.diffthis('~') end, mapopts(bufnr) },

                { '<leader>eq', gs.setqflist, mapopts(bufnr) },
                { '<leader>eQ', function() gs.setqflist('all') end, mapopts(bufnr) },

                { '<leader>er', gs.reset_hunk, mapopts(bufnr) },
                { '<leader>eR', gs.reset_buffer, mapopts(bufnr) },
                -- stylua: ignore end
            })

            keymap.xmap({ 'ih', gs.select_hunk, mapopts(bufnr) })
        end,
    },
}
