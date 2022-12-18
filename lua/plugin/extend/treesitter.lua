local is_available, TS_configs = pcall(require, "nvim-treesitter.configs")
if not is_available then
  return
end

TS_configs.setup({
  ensure_installed = {
    "bash",
    "cpp",
    "c",
    "css",
    "html",
    "javascript",
    "java",
    "lua",
    "python",
    "vim",
    "yaml",
    "rasi",
    "norg",
    "markdown",
  },
  ignore_install = {},
  highlight = {
    enable = true,
    -- disable = { "help" },
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "<C-n>",
      node_decremental = "<C-p>",
      scope_incremental = "<C-s>",
    },
  },
  indent = {
    enable = true,
  },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.bash.filetype_to_parsename = { "sh", "zsh" }
