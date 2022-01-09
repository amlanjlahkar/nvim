local is_available, TS_configs = pcall(require, "nvim-treesitter.configs")
if not is_available then
    return
end

TS_configs.setup {
    ensure_installed = { "cpp", "c", "css", "html", "javascript", "lua", "python", "vim" },
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    },
}
