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
vim.g.indent_blankline_context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "switch_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
}
g.indent_blankline_show_first_indent_level = true
g.indent_blankline_use_treesitter = true
