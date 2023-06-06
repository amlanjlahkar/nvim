return {
  {
    "tummetott/reticle.nvim",
    -- enabled = false,
    event = "VeryLazy",
    opts = {
      ignore = { cursorline = { "lazy", "lspinfo" } },
    },
  },

  {
    "stevearc/dressing.nvim",
    enabled = false,
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
    enabled = false,
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
