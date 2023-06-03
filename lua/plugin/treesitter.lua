return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },

    opts = {
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
      indent = {
        enable = true,
      },
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
        move = {
          enable = false,
          set_jumps = true,
          goto_next_start = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_next_end = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_previous_start = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
          goto_previous_end = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["]a"] = "@parameter.inner",
          },
          swap_previous = {
            ["]A"] = "@parameter.inner",
          },
        },
        lsp_interop = {
          enable = false,
          border = "single",
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dc"] = "@class.outer",
          },
        },
      },
    },

    config = function(_, opts)
      local ts_install = require("nvim-treesitter.install")
      local parsers = require("nvim-treesitter.parsers")
      local parser_config = parsers.get_parser_configs()

      ts_install.compilers = { "zig", "clang", "gcc" }
      ts_install.update({ with_sync = false })

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

      require("nvim-treesitter.configs").setup(opts)
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
