-- Enable experimental lua module loader from lazy
vim.loader.enable()
-- :help ui2
require('vim._core.ui2').enable({})

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

local cwd = vim.uv.cwd()
if cwd ~= os.getenv('HOME') then
    handle = vim.system(find_cmd, {
        cwd = cwd,
        text = true,
    }, on_exit)
end

vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('cfilter')

require('colorscheme')
vim.g.boo_colorscheme_italic = false
vim.cmd.colorscheme('boo')
