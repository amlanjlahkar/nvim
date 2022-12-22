return {
  "nvim-lua/plenary.nvim",
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
}
