local is_available, telescope = pcall(require, "telescope")
if not is_available then
  return
end

telescope.setup {
  defaults = {
    prompt_prefix = " 🔍 ",
    multi_icon = " + ",
    layout_config = {
      center = {
        height = 0.5,
        prompt_position = "bottom",
        width = 0.4,
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
    file_ignore_patterns = { "vendor" },
  },
  pickers = {
    find_files = {
      hidden = false,
      previewer = false,
      layout_strategy = "center",
    },
    help_tags = {
      hidden = false,
      previewer = false,
      layout_strategy = "center",
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

-- keymaps
local wk = require("which-key")
local telescope_wk_mappings = {
  t = {
    name = "Telescope",
    f = { '<cmd>lua require("telescope.builtin").find_files()<CR>', "Find files" },
    b = { '<cmd>lua require("telescope.builtin").buffers()<CR>', "Switch between buffers" },
    g = { '<cmd>lua require("telescope.builtin").live_grep()<CR>', "Live grep" },
    h = { '<cmd>lua require("telescope.builtin").help_tags()<CR>', "Help tags" },
    n = { '<cmd>lua require("telescope.builtin").find_files({cwd = "~/.config/nvim/" })<CR>', "Find nvim confs" },
  },
}
wk.register(telescope_wk_mappings, { prefix = "<leader>" })
