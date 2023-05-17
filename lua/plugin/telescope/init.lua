local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  keys = require("plugin.telescope.mapping").prefix,
}

M.opts = function()
  local actions = require("telescope.actions")
  local actions_layout = require("telescope.actions.layout")
  return {
    defaults = {
      prompt_prefix = "  ",
      selection_caret = " ",
      multi_icon = " ",
      preview = false,
      layout_config = {
        horizontal = {
          width = 0.9,
          height = 0.9,
        },
      },
      buffer_previewer_maker = require("plugin.telescope.function").buf_preview_maker,
      history = { path = vim.fn.stdpath("state") .. "/telescope_history.log" },
      --stylua: ignore
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-w>"] = function() vim.api.nvim_input("<C-S-w>") end,
          ["<C-s>"] = actions.toggle_selection,
          ["<M-p>"] = actions_layout.toggle_preview,
        },
      },
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
        "node_modules/*",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  }
end

function M.config(_, opts)
  require("telescope").setup(opts)
  local extensions = { "fzf" }
  for _, ext in pairs(extensions) do
    require("telescope").load_extension(ext)
  end
  require("plugin.telescope.mapping"):setup()
end

return M
