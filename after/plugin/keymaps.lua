local api = vim.api

local keymap = require('utils.keymap')
local opts = keymap.new_opts
local nosilent, expr = opts(keymap.nosilent), opts(keymap.expr)

keymap.nmap({
    { '<leader>j', ':m .+1<CR>==' },
    { '<leader>k', ':m .-2<CR>==' },
    { 'gV', '`[v`]' },
})

keymap.xmap({
    { '<', '<gv' },
    { '>', '>gv' },
    { 'J', ":m '>+1<CR>gv=gv" },
    { 'K', ":m '<-2<CR>gv=gv" },
    { 'v', 'yP' },
})

-- yanking {{{1
-- Retain cursor postion after yanking
local get_curpos = function()
    return api.nvim_win_get_cursor(0)
end
local curpos
keymap.nxmap({
    -- stylua: ignore start
    { "y", function() curpos = get_curpos() return "y" end, expr },
    { "<C-y>", function() curpos = get_curpos() return '"+y' end, expr },
    { "<C-e>", '"+yy' },
    -- stylua: ignore end
})

vim.keymap.set('n', 'Y', function()
    curpos = get_curpos()
    return 'y$'
end, { expr = true })

api.nvim_create_autocmd('TextYankPost', {
    group = api.nvim_create_augroup('_core.keymap', { clear = true }),
    callback = function()
        if vim.v.event.operator == 'y' and curpos then
            api.nvim_win_set_cursor(0, curpos)
        end
    end,
})
