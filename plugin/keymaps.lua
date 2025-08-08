local api = vim.api

local keymap = require('utils.keymap')
local mapopts = keymap.new_opts

keymap.nmap({
    { '<leader>j', '<Cmd>m .+1<CR>==' },
    { '<leader>k', '<Cmd>m .-2<CR>==' },
    { 'gV', '`[v`]' },
})

keymap.xmap({
    { '<', '<gv' },
    { '>', '>gv' },
    { 'v', 'yP' },
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

-- Yanking {{{1
-- Retain cursor postion after yanking
local curpos
local get_curpos = function()
    return api.nvim_win_get_cursor(0)
end

keymap.nxmap({
    -- stylua: ignore start
    { "y", function() curpos = get_curpos() return "y" end, mapopts(keymap.expr) },
    { "<C-y>", function() curpos = get_curpos() return '"+y' end, mapopts(keymap.expr) },
    { "<C-e>", '"+yy' },
    -- stylua: ignore end
})

api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        if vim.v.event.operator == 'y' and curpos then
            api.nvim_win_set_cursor(0, curpos)
        end
    end,
})
