vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

require('config.lazy')
require('config.lsp')

require('vim._core.ui2').enable({})
