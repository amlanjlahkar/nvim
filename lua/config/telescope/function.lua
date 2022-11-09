local fn = vim.fn
local api = vim.api

local M = {}

local tb = require("telescope.builtin")
M.get_nvim_conf = function()
  local opts = {
    prompt_title = "Neovim conf",
    cwd = fn.stdpath("config"),
    layout_strategy = "center",
  }
  tb.find_files(opts)
end

M.get_relative_file = function()
  local opts = {
    prompt_title = "Files",
    cwd = fn.expand("%:p:h"),
    layout_strategy = "center",
  }
  tb.find_files(opts)
end

M.get_dwots = function()
  local dothome = fn.finddir("~/dwots/")
  local opts = {
    prompt_title = "Dotfiles",
    cwd = dothome,
    hidden = true,
    find_command = { "fd", "--exclude", ".git/", "--type", "file" },
    layout_strategy = "center",
  }
  if dothome == "" then
    vim.notify("Direcetory dwots not found!", vim.log.levels.ERROR)
  else
    tb.find_files(opts)
  end
end

return M
