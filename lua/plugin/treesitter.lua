return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    event = "BufReadPost",

    config = function()
      require("nvim-treesitter.configs").setup({
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
          "rust",
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
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
          swap = {
            enable = false,
            swap_next = {
              ["]]"] = "@parameter.inner",
            },
            swap_previous = {
              ["]["] = "@parameter.inner",
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
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "markdown", "javascriptreact" },
    config = true
  },
}
