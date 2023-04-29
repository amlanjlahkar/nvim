return {
  { "utilyre/sentiment.nvim", event = "VeryLazy", config = true },

  {
    "norcalli/nvim-colorizer.lua",
    enabled = false,
    lazy = false,
    config = function()
      require("colorizer").setup()
    end,
  },

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
    "stevearc/dressing.nvim",
    event = "LspAttach",
    opts = {
      input = {
        border = "single",
        get_config = function(opts)
          if string.match(opts.prompt, "Arguments to pass: ") then
            return {
              relative = "win",
            }
          end
        end,
      },
      win_options = {
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
      },
      select = {
        builtin = { border = "single" },
        telescope = { layout_strategy = "horizontal" },
        -- telescope = require("plugin.telescope.function").use_theme(),
        get_config = function(opts)
          -- JdtWipeDataAndRestart
          if opts.prompt and string.match(opts.prompt, "wipe the data folder") then
            return {
              backend = "builtin",
              builtin = { width = 0.8, height = 0.3 },
            }
          end
        end,
      },
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
}
