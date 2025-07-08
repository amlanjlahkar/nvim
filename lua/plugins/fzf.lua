local prefix = '<leader>q'

return {
    'ibhagwan/fzf-lua',
    cmd = { 'FzfLua' },
    keys = { prefix },
    opts = {
        winopts = {
            height = 0.8,
            width = 0.5,
            row = 0.2, -- (0=top, 1=bottom)
            col = 0.5, -- (0=left, 1=right)
            border = 'single',
            title_flags = false,
            preview = {
                hidden = true,
                title = false,
                scrollbar = false,
                vertical = 'down:60%',
            },
        },

        actions = function()
            local actions = require('fzf-lua').actions

            return {
                files = {
                    false,
                    -- keybinds follow the fzf syntax
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
                ['<Bslash>'] = 'toggle-preview',
                ['<S-k>'] = 'preview-page-up',
                ['<S-j>'] = 'preview-page-down',
                ['<C-k>'] = 'preview-up',
                ['<C-j>'] = 'preview-down',
            },
            fzf = {
                false,
                -- keybinds follow the fzf syntax
                ['ctrl-s'] = 'toggle-all',
            },
        },

        files = {
            hidden = false,
        },
    },
    config = function(plugin)
        require('fzf-lua').setup(plugin.opts)

        local keymap = require('utils.keymap')

        keymap.nmap({
            { prefix .. 'p', ':FzfLua files<CR>' },
            { prefix .. 'o', ':FzfLua oldfiles<CR>' },
            { prefix .. 'b', ':FzfLua buffers<CR>' },
            { prefix .. 's', ':FzfLua live_grep<CR>' },
            { prefix .. 'h', ':FzfLua helptags<CR>' },
            { prefix .. 'u', ':FzfLua resume<CR>' },
        })
    end,
}
