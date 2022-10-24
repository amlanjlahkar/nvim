local is_available, wk = pcall(require, "which-key")
if not is_available then
  return
end

local fn = require("config.telescope.function")
local telescope_wk_mappings = {
  t = {
    name = "Telescope",
    t = { '<cmd>lua require("telescope.builtin").find_files({ layout_strategy = "center" })<CR>', "Buffers" },
    b = { '<cmd>lua require("telescope.builtin").buffers()<CR>', "Buffers" },
    g = { '<cmd>lua require("telescope.builtin").live_grep()<CR>', "Live grep" },
    h = { '<cmd>lua require("telescope.builtin").help_tags()<CR>', "Help tags" },
    n = {
      function()
        fn.get_nvim_conf()
      end,
      "Neovim conf",
    },
    f = {
      function()
        fn.get_relative_file()
      end,
      "Get relative files",
    },
    d = {
      function()
        fn.get_dwots()
      end,
      "Get dotfiles",
    },
  },
}
wk.register(telescope_wk_mappings, { prefix = "<leader>" })
