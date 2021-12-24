vim.opt.list = true
require("indent_blankline").setup {
    buftype_exclude = { "terminal" },
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
}
-- disable indentlines on specific filetypes and on terminal mode
vim.g['indent_blankline_filetype_exclude'] = { 'help', 'text', 'markdown', 'git' }
