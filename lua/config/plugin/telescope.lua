local is_available, telescope = pcall(require, "telescope")
if not is_available then
    return
end
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

telescope.load_extension('fzy_native')
telescope.setup {
    defaults = {
        prompt_prefix = ' 🔍 ',
        selection_caret = ' > ',
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--trim"
        },
    },
    pickers = {
        find_files = {
            hidden = false,
            previewer = false,
            layout_strategy = "center",
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    }
}

local M = {}
M.get_files = function()
    builtin.find_files({
        cwd = utils.buffer_dir(),
    })
end

-- keymaps
map('n', '<leader>tg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
map('n', '<leader>tn', '<cmd>lua require("telescope.builtin").find_files({cwd = "~/.config/nvim",})<cr>', opts)
map('n', '<C-f>',      '<cmd>lua require("config/plugin/telescope").get_files()<cr>', opts)

return M
