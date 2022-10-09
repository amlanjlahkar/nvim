local M = {}

local tb = require("telescope.builtin")
M.get_nvim_conf = function()
  local opts = {
    prompt_title = "Neovim conf",
    cwd = vim.fn.stdpath("config"),
    layout_strategy = "center",
  }
  tb.find_files(opts)
end

M.get_relative_file = function()
  local opts = {
    prompt_title = "Files",
    cwd = vim.fn.expand("%:p:h"),
    layout_strategy = "center",
  }
  tb.find_files(opts)
end

M.get_dwots = function()
  local opts = {
    prompt_title = "Dotfiles",
    cwd = os.getenv("HOME") .. "/dwots/",
    hidden = true,
    find_command = { "fd", "--exclude", ".git/", "--type", "file" },
    layout_strategy = "center",
  }
  tb.find_files(opts)
end

return M
