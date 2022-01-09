local is_available, telescope = pcall(require, "telescope")
if not is_available then
    return
end

telescope.setup {
    defaults = {
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
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    }
}

-- keymaps
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<C-f>', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
map('n', '<leader>tg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
map('n', '<leader>n', '<cmd>lua require("config/plugin/telescope").nvim_files()<cr>', opts)

-- extensions
telescope.load_extension('fzy_native')
local is_available, harpoon = pcall(require, "harpoon")
if is_available then
    telescope.load_extension('harpoon')
    map('n', '<leader>tm', '<cmd>Telescope harpoon marks<cr>', opts)
else
    return
end

-- custom functions
local M = {}
M.nvim_files = function()
    require("telescope.builtin").find_files({
        prompt_title = "Nvim >",
        cwd = vim.fn.stdpath("config"),
        hidden = false,
    })
end

return M
