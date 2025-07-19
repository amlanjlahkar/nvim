local prefix = '<leader>q'

return {
    'ibhagwan/fzf-lua',
    cmd = { 'FzfLua' },
    dev = false,
    keys = { prefix },
    opts = {
        winopts = {
            height = 0.8,
            width = 0.5,
            row = 0.2, -- (0=top, 1=bottom)
            col = 0.5, -- (0=left, 1=right)
            backdrop = 100,
            border = 'single',
            title_flags = false,
            preview = {
                hidden = true,
                title = false,
                scrollbar = false,
                vertical = 'down:60%',
                border = 'single',
            },
        },

        actions = function()
            local actions = require('fzf-lua').actions

            return {
                files = {
                    false,
                    -- Keybinds follow the fzf syntax
                    ['enter'] = actions.file_switch_or_edit,
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-v'] = actions.file_vsplit,
                    ['ctrl-t'] = actions.file_tabedit,
                    ['ctrl-q'] = actions.file_sel_to_qf,
                    ['ctrl-h'] = actions.toggle_hidden,
                },
            }
        end,

        keymap = {
            builtin = {
                false,
                -- ['<Bslash>'] = 'toggle-preview',
                ['<S-k>'] = 'preview-page-up',
                ['<S-j>'] = 'preview-page-down',
                ['<C-k>'] = 'preview-up',
                ['<C-j>'] = 'preview-down',
            },
            fzf = {
                false,
                -- Keybinds follow the fzf syntax
                ['ctrl-s'] = 'toggle-all',
            },
        },

        files = {
            hidden = false,
            fd_opts = [[--color=never --type f --type l --exclude .git --exclude .jj --no-require-git]],
        },

        oldfiles = {
            cwd_only = true,
        },

        grep = {
            rg_opts = [[--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --no-require-git -e]],
        },
    },
    config = function(plugin)
        local fzf = require('fzf-lua')

        fzf.setup(plugin.opts)

        local keymap = require('utils.keymap')

        keymap.nmap({
            { prefix .. 'p', ':FzfLua files<CR>' },
            { prefix .. 'o', ':FzfLua oldfiles<CR>' },
            { prefix .. 'b', ':FzfLua buffers<CR>' },
            { prefix .. 'l', ':FzfLua live_grep<CR>' },
            { prefix .. 'h', ':FzfLua helptags<CR>' },
            { prefix .. 'u', ':FzfLua resume<CR>' },
            {
                prefix .. 'n',
                function()
                    fzf.files({
                        cwd = vim.fn.stdpath('config'),
                    })
                end,
            },
            {
                prefix .. 's',
                function()
                    local cwd = vim.fn.expand('%:p:h')
                    fzf.files({
                        cwd = cwd,
                    })
                end,
            },
        })
    end,
}
