vim.pack.add({
    'https://github.com/stevearc/oil.nvim',
})

local opts = {
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
    },
    lsp_file_methods = {
        enabled = false,
    },
}

require('oil').setup(opts)

vim.keymap.set('n', '-', '<Cmd>Oil<CR>', { desc = 'Open parent directory' })
