return {
  "nvim-lua/plenary.nvim",
  { "tpope/vim-fugitive", cmd = "Git" },
  { "utilyre/sentiment.nvim", event = "VeryLazy", config = true },

  {
    "tummetott/reticle.nvim",
    event = "VeryLazy",
    opts = {
      ignore = { cursorline = { "lazy", "lspinfo" } },
    },
  },

  {
    "folke/trouble.nvim",
    module = false,
    cmd = { "Trouble", "TroubleToggle" },
    opts = {
      mode = "document_diagnostics",
      padding = false,
      icons = false,
      fold_open = "",
      fold_closed = "",
      indent_lines = false,
      use_diagnostic_signs = true,
    },
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
        "StatusColSep",
        "StatusLine",
        "StatusLineNC",
        "StatusLineImp",
        "StatusLineInd",
        "StatusLineDiagnosticError",
        "StatusLineDiagnosticWarn",
        "StatusLineDiagnosticHint",
        "StatusLineDiagnosticInfo",
        "TreesitterContext",
      },
    },
  },

  {
    "rockerBOO/boo-colorscheme-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.boo_colorscheme_theme = "crimson_moonlight"
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    enabled = false,
    lazy = false,
    config = function()
      require("colorizer").setup()
    end,
  },
}
