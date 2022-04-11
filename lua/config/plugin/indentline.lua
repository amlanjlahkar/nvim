local is_available, indent_blankline = pcall(require, "indent_blankline")
if not is_available then
    return
end

local g = vim.g
indent_blankline.setup {
    max_indent_increase = 1,
    use_treesiter = false,
    show_current_context = true,
    show_current_context_start = false,
    show_trailing_blankline_indent = false,
    space_char_blankline = " ",
}

g.indent_blankline_buftype_exlude = { 'terminal', 'nofile' }
g.indent_blankline_filetype_exclude = {
    'conf',
    'checkhealth',
    'css',
    'help',
    'text',
    'markdown',
    'git',
    'packer',
    'dashboard',
    'lspinfo',
    'TelescopePrompt',
    'TelescopeResults',
    'trouble',
}
vim.g.indent_blankline_context_patterns = {
    "class",
    "return",
    "function",
    "^if",
    "method",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "switch_statement",
    "^case",
    "catch_clause",
    "import_statement",
    "operation_type",
}
