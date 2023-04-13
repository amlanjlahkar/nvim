return {
  "nvim-lua/plenary.nvim",
  "mfussenegger/nvim-jdtls",
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
    enabled = true,
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
    keys = { "s", { "S", mode = "x" } },
    config = function()
      require("mini.surround").setup({
        silent = true,
        highlight_duration = 100,
        search_method = "cover_or_nearest",
      })
      vim.keymap.set("x", "S", [[:lua MiniSurround.add("visual")<CR>]], { silent = true })
    end,
  },

  {
    "echasnovski/mini.pairs",
    enabled = false,
    version = false,
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup()
    end,
  },

  {
    "echasnovski/mini.comment",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    version = false,
    keys = { "gc", { "gc", mode = "x" } },
    config = function()
      local avail, ts_config = pcall(require, "nvim-treesitter['config']")
      if avail then
        ts_config.setup({
          context_commentstring = {
            enable = true,
            enable_autocmd = false,
          },
        })
      end
      require("mini.comment").setup({
        hooks = {
          pre = function()
            require("ts_context_commentstring.internal").update_commentstring()
          end,
        },
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

  {
    "norcalli/nvim-colorizer.lua",
    enabled = false,
    lazy = false,
    config = function()
      require("colorizer").setup()
    end,
  },
}
