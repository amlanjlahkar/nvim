return {
  "nvim-lua/plenary.nvim",
  "mfussenegger/nvim-jdtls",
  { "tpope/vim-fugitive", cmd = "Git" },

  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "CursorMoved",
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },

  {
    "tummetott/reticle.nvim",
    event = "VeryLazy",
    opts = {
      ignore = { cursorline = { "lazy", "lspinfo" } },
    },
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb", { "gc", mode = "x" }, { "gb", mode = "x" } },
    config = true,
  },

  {
    "kylechui/nvim-surround",
    keys = { "ys", "ds", "cs", { "S", mode = "x" } },
    config = true,
  },

  {
    "folke/trouble.nvim",
    module = false,
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      icons = false,
      fold_open = "",
      fold_closed = "",
      indent_lines = false,
      use_diagnostic_signs = true,
    },
  },

  {
    "echasnovski/mini.indentscope",
    version = "*",
    event = "CursorMoved",
    config = function()
      require("mini.indentscope").setup({ delay = 50, symbol = "│" })
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("_plug", { clear = true }),
        pattern = { "help", "lazy", "telescopeprompt", "trouble", "oil", "fugitive" },
        command = "lua vim.b.miniindentscope_disable = true",
      })
    end,
  },

  {
    "xiyaowong/nvim-transparent",
    opts = {
      extra_groups = {
        "NormalFloat",
        "FloatBorder",
        "WinBar",
        "WinBarNC",
        "CursorLine",
        "VertSplit",
        "TabLineFill",
        "GitGutterAdd",
        "GitGutterChange",
        "GitGutterDelete",
        "DiffLine",
        "CmpItemAbbr",
        "StatusLine",
        "StatusLineNC",
        "StatusLineImp",
        "StatusLineInd",
        "StatusLineDiagnosticError",
        "StatusLineDiagnosticWarn",
        "StatusLineDiagnosticHint",
        "StatusLineDiagnosticInfo",
      },
    },
  },

  {
    "rockerBOO/boo-colorscheme-nvim",
    config = function()
      vim.g.boo_colorscheme_theme = "crimson_moonlight"
    end,
  },
}
