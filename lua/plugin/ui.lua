return {
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
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        LAZYLOAD("dressing.nvim")
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        LAZYLOAD("dressing.nvim")
        return vim.ui.input(...)
      end
    end,
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
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      extra_groups = {
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
    config = function()
      vim.g.boo_colorscheme_theme = "crimson_moonlight"
    end,
  },
}
