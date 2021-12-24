require('nvim-treesitter.configs').setup {
    ensure_installed = { "cpp", "c", "css", "html", "javascript", "lua", "python", "vim" },
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    },
}
