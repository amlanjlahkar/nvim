return {
  {
    "echasnovski/mini.indentscope",
    enabled = false,
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.indentscope").setup({ delay = 50, symbol = "│" })
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("_plug", { clear = true }),
        pattern = { "help", "lazy", "telescopeprompt", "trouble", "^oil*", "^clangd*", "fugitive", "checkhealth", "" },
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
    "echasnovski/mini.ai",
    version = false,
    lazy = false,
    dependencies = "nvim-treesitter-textobjects",
    opts = function()
      local ai = require("mini.ai")
      return {
        silent = true,
        n_lines = 100,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          g = function()
            local eol = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = { line = 1, col = 1 }, to = eol }
          end,
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
}
