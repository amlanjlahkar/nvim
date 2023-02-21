return {
  "nvim-lua/plenary.nvim",
  "mfussenegger/nvim-jdtls",
  { "tpope/vim-fugitive", cmd = "Git" },

  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
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
    lazy = false,
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
    "xiyaowong/nvim-transparent",
    -- lazy = false,
    cmd = "TransparentToggle",
    opts = {
      enable = false,
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
