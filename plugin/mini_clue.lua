vim.pack.add({
    'https://github.com/echasnovski/mini.clue',
})

local miniclue = require('mini.clue')

miniclue.setup({
    triggers = {
        { mode = { 'n', 'x' }, keys = '<Leader>' },
        { mode = { 'n', 'x' }, keys = 'g' },
        { mode = { 'n', 'x' }, keys = "'" },
        { mode = { 'n', 'x' }, keys = '`' },
        { mode = { 'n', 'x' }, keys = '"' },
        { mode = { 'i', 'c' }, keys = '<C-r>' },
        { mode = { 'n', 'x' }, keys = 'z' },
    },
    clues = {
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.z(),
    },
    window = {
        config = function()
            return {
                anchor = 'SE',
                row = 'auto',
                width = 'auto',
            }
        end,
    },
})
