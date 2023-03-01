local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "dharmx/telescope-media.nvim",
  },
  cmd = "Telescope",
  keys = "<leader>t",
}

function M.config()
  require("telescope").setup({
    defaults = {
      prompt_prefix = "   ",
      selection_caret = "  ",
      multi_icon = "  ",
      preview = false,
      buffer_previewer_maker = require("plugin.telescope.function").buf_preview_maker,
      history = { path = vim.fn.stdpath("state") .. "/telescope_history.log" },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--trim",
      },
      file_ignore_patterns = {
        "vendor/*",
        "node_modules/*",
        "spell/*",
        "**/*.class",
        "**/*.jar",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      media = {
        backend = "ueberzug",
      },
    },
  })
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("media")

  require("plugin.telescope.mapping").setup()
end

return M
