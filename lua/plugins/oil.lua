return {
    'stevearc/oil.nvim',
    version = 'v2.*',
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        columns = {
            'permissions',
            'size',
            'mtime',
        },
        keymaps = {
            ['<CR>'] = false,
            ['<C-j>'] = 'actions.select',
        },
        view_options = {
            show_hidden = true,
        }
    },
    config = function(plugin)
        require('oil').setup(plugin.opts)
        vim.keymap.set('n', '-', '<Cmd>Oil<CR>', { desc = 'Open parent directory' })
    end,
}
