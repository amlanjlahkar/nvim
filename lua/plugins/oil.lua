return {
    'stevearc/oil.nvim',
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
    },
    config = function(plugin)
        require('oil').setup(plugin.opts)
        vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
}
