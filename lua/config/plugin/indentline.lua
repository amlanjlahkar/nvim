local g = vim.g

vim.opt.list = true
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = false,
}

g.indent_blankline_buftype_exlude = { 'terminal', 'nofile' }
g.indent_blankline_filetype_exclude = {
   'help',
   'text',
   'markdown',
   'git',
   'packer',
   'dashboard',
   'lspinfo',
   'TelescopePrompt',
   'TelescopeResults',
}
g.indent_blankline_show_first_indent_level = true
g.indent_blankline_use_treesitter = true
