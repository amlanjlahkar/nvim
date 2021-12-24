require("bufferline").setup {
    options = {
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
        enforce_regular_tabs = false,
        max_name_length = 20,
        modified_icon = '',
        numbers = function(opts)
            return string.format('%s. ', opts.ordinal)
        end
    },
    highlights = {
        background = {
            guibg = '#1d2021',
        },
        fill = {
            guibg = '#1d2021',
        },
        buffer_visible = {
            guibg = '#1d2021',
        },
        buffer_selected = {
            gui = "bold",
        },
        indicator_selected = {
            guifg = '#7daea3',
        },
        separator = {
            guifg = '#1d2021'
        },
        separator_selected = {
            guifg = '#1d2021'
        }

    }
}

-- keymap
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>f', '<cmd>BufferLinePick<cr>', opts)
map ('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<cr>', opts)
map ('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<cr>', opts)
map ('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<cr>', opts)
map ('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<cr>', opts)
map ('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<cr>', opts)

