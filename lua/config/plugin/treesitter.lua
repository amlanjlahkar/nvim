local is_available, TS_configs = pcall(require, "nvim-treesitter.configs")
if not is_available then
    return
end

TS_configs.setup {
    ensure_installed = { "bash", "cpp", "c", "css", "html", "javascript", "lua", "python", "vim", "yaml" },
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    },
}
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.bash.used_by = { "sh", "zsh" }
