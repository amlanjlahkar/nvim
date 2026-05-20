vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

require('config.opts')
require('config.keymaps')
require('config.usercmds')
require('config.autocmds')
require('config.lsp')

require('vim._core.ui2').enable({})

vim.cmd.packadd('nvim.undotree')
