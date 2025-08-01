vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
                    { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = 'plugins' },
    },
    pkg = { enabled = false },
    rocks = { enabled = false },
    dev = { path = '~/Projects/nvim_plugins' },
    ui = { pills = false, backdrop = 100 },
    install = { colorscheme = { 'boo', 'default' } },
    change_detection = { enabled = false },
})

require('lsp')
