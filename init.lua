-- Enable experimental lua module loader from lazy
vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

require('config.opts')
require('config.keymaps')
require('config.usercmds')
require('config.autocmds')
require('config.lsp')

-- Retrieve directories relative to cwd
-- to be set as the value of 'path'
local find_cmd = {
    'fd',
    '--no-follow',
    '--hidden',
    '--exclude=.git',
    '--exclude=.jj',
    '--no-require-git',
    '--color=never',
    '--type=d',
}

local handle = {}

local on_exit = function(obj)
    assert(obj.code, obj.stderr)

    local path = string.gsub(handle._state.stdout_data[1], '\n', ',')

    vim.schedule(function()
        vim.opt.path = '.,' .. path
    end)
end

handle = vim.system(find_cmd, {
    cwd = vim.uv.cwd(),
    text = true,
}, on_exit)

-- :help ui2
require('vim._core.ui2').enable({})

vim.cmd.packadd('nvim.undotree')
