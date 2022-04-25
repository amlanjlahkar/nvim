local is_available, bufferline = pcall(require, "bufferline")
if not is_available then
    return
end

bufferline.setup {
    options = {
        modified_icon = '● ',
        offsets = {{filetype = "netrw", text = "Explorer", text_align = "center"}},
        show_tab_indicators = true,
        enforce_regular_tabs = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        tab_size = 25,
        max_name_length = 25,
        --[[ numbers = function(opts)
            return string.format('%s. ', opts.ordinal)
        end ]]
    },
    highlights = {
        indicator_selected = {
            guifg = "#80a0ff",  
        },
    }
}

-- keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<leader>f', '<cmd>BufferLinePick<cr>', opts)
map('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<cr>', opts)
map('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<cr>', opts)
map('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<cr>', opts)
map('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<cr>', opts)
map('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<cr>', opts)

