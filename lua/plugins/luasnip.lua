return {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    enabled = false,
    -- Lazyloaded as it's being utilized by blink.cmp
    lazy = true,

    config = function()
        local ls = require('luasnip')
        local types = require('luasnip.util.types')

        ls.setup({
            update_events = { 'TextChanged', 'TextChangedI' },
            region_check_events = 'CursorMoved',
            delete_check_events = 'TextChanged',
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { '', 'SnipChoiceNode' } },
                    },
                },
                [types.insertNode] = {
                    active = {
                        virt_text = { { '', 'SnipInsertNode' } },
                    },
                },
            },
        })

        -- Load snippets by filetype
        require('luasnip.loaders.from_lua').lazy_load({
            paths = vim.fn.stdpath('config') .. '/snippets',
        })

        -- Keymaps
        local keymap = require('utils.keymap')
        local tab = vim.api.nvim_replace_termcodes('<TAB>', true, false, true)

        keymap.ismap({
            {
                '<TAB>',
                function()
                    if ls.expand_or_locally_jumpable() then
                        ls.expand_or_jump()
                    else
                        vim.api.nvim_feedkeys(tab, 'n', false)
                    end
                end,
            },

            {
                '<S-TAB>',
                function()
                    if ls.jumpable(-1) then
                        ls.jump(-1)
                    end
                end,
            },

            {
                '<C-j>',
                function()
                    if ls.choice_active() then
                        ls.change_choice(1)
                    end
                end,
            },

            {
                '<C-k>',
                function()
                    if ls.choice_active() then
                        require('luasnip.extras.select_choice')()
                    end
                end,
            },
        })
    end,
}
