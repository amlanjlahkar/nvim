local api = vim.api

local keymap = require('utils.keymap')
local mapopts = keymap.new_opts

keymap.nmap({
    { '<leader>j', '<Cmd>m .+1<CR>==' },
    { '<leader>k', '<Cmd>m .-2<CR>==' },
    { 'gV', '`[v`]' },
    { '<localleader>o', ':bp<CR>' },
    { '<localleader>p', ':bn<CR>' },
    { '<C-e>', '"+yy' },
})

keymap.xmap({
    { '<', '<gv' },
    { '>', '>gv' },
    { 'v', 'yP' },
    { '<C-y>', '"+y' },
})

keymap.tmap({
    { '<C-n>', '<C-\\><C-n>' },
})

keymap.cmap({
    {
        '%%',
        function()
            return vim.fn.getcmdtype() == ':' and string.format('%s/', vim.fn.expand('%:h')) or '%%'
        end,
        mapopts(keymap.expr, keymap.nosilent, 'Append to relative path'),
    },
})
