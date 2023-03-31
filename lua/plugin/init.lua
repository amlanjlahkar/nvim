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
    enabled = false,
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.indentscope").setup({ delay = 50, symbol = "│" })
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("_plug", { clear = true }),
        pattern = { "help", "lazy", "telescopeprompt", "trouble", "^oil*", "fugitive", "checkhealth", "" },
        command = "lua vim.b.miniindentscope_disable = true",
      })
    end,
  },

  {
    "echasnovski/mini.surround",
    version = false,
    keys = "s",
    config = function()
      require("mini.surround").setup({
        silent = true,
        highlight_duration = 100,
        search_method = "cover_or_nearest",
      })
    end,
  },

  {
    "echasnovski/mini.pairs",
    version = false,
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup()
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

  {
    "norcalli/nvim-colorizer.lua",
    lazy = true,
    config = function()
      require("colorizer").setup()
    end,
  },
}
