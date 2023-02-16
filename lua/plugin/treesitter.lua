local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
  build = function()
    local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
    ts_update()
  end,
  event = "BufReadPost",
}

function M.config()
  local ts_config = require("nvim-treesitter.configs")
  ts_config.setup({
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
      "markdown",
      "help",
    },
    ignore_install = {},
    highlight = {
      enable = true,
      disable = { "help" },
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
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
        border = "single",
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dc"] = "@class.outer",
        },
      },
    },
    indent = {
      enable = true,
    },
  })
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.bash.filetype_to_parsename = "sh"
end

return M
