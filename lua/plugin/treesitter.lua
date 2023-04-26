return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },

    config = function()
      require("nvim-treesitter.install").update({ with_sync = false })
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "comment",
          "cpp",
          "css",
          "html",
          "java",
          "javascript",
          "lua",
          "luap",
          "markdown",
          "python",
          "rasi",
          "rust",
          "vim",
          "vimdoc",
          "yaml",
        },
        ignore_install = {},
        highlight = {
          enable = true,
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
        --   select = {
        --     enable = true,
        --     lookahead = true,
        --     keymaps = {
        --       ["as"] = "@scope",
        --       ["aa"] = "@parameter.outer",
        --       ["ia"] = "@parameter.inner",
        --       ["af"] = "@function.outer",
        --       ["if"] = "@function.inner",
        --       ["ac"] = "@class.outer",
        --       ["ic"] = "@class.inner",
        --     },
        --   },
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
      local parsers = require("nvim-treesitter.parsers")
      local parser_config = parsers.get_parser_configs()

      parser_config.bash.filetype_to_parsename = "sh"
      -- local augroup = vim.api.nvim_create_augroup("_plug", { clear = true })
      -- vim.api.nvim_create_autocmd("FileType", {
      --   group = augroup,
      --   pattern = table.concat(
      --     vim.tbl_map(function(ft)
      --       return parser_config[ft].filetype or ft
      --     end, parsers.available_parsers()),
      --     ","
      --   ),
      --   command = "setl fdm=expr fde=nvim_treesitter#foldexpr()",
      -- })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      require("treesitter-context").setup({
        max_lines = 5,
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "markdown", "javascriptreact" },
    config = true,
  },
}
