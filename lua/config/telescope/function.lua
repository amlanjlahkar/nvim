local fn = vim.fn
local api = vim.api

local M = { layout_strategy = "vertical" }

local tb = require("telescope.builtin")
function M:get_nvim_conf()
  local opts = {
    prompt_title = "Neovim conf",
    cwd = fn.stdpath("config"),
    layout_strategy = self.layout_strategy,
  }
  tb.find_files(opts)
end

function M:get_relative_file()
  local opts = {
    prompt_title = "Files",
    cwd = fn.expand("%:p:h"),
    layout_strategy = self.layout_strategy,
  }
  tb.find_files(opts)
end

function M:get_dwots()
  local dothome = fn.finddir("~/dwots/")
  local opts = {
    prompt_title = "Dotfiles",
    cwd = dothome,
    hidden = true,
    find_command = { "fd", "--exclude", ".git/", "--type", "file" },
    layout_strategy = self.layout_strategy,
  }
  if dothome == "" then
    vim.notify("Direcetory dwots not found!", vim.log.levels.ERROR)
  else
    tb.find_files(opts)
  end
end

return M
