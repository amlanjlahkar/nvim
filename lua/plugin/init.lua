return {
  "nvim-lua/plenary.nvim",
  "mfussenegger/nvim-jdtls",
  { "tpope/vim-fugitive", cmd = "Git" },

  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup({
        icons = false,
        fold_open = "",
        fold_closed = "",
        indent_lines = false,
        use_diagnostic_signs = true,
      })
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    lazy = false,
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "xiyaowong/nvim-transparent",
    cmd = "TransparentToggle",
    config = function()
      require("transparent").setup({
        enable = false,
        extra_groups = {
          "NormalFloat",
          "FloatBorder",
          "WinBar",
          "WinBarNC",
          "CursorLine",
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
      })
    end,
  },

  {
    "rockerBOO/boo-colorscheme-nvim",
    config = function()
      vim.g.boo_colorscheme_theme = "crimson_moonlight"
    end,
  },
}
