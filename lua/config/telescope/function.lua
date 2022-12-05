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

function M:set_bg()
  local path = fn.finddir("~/media/pictures/wallpapers/")
  local opts = {
    prompt_title = "Wallpaper",
    cwd = path,
    layout_strategy = self.layout_strategy,

    attach_mappings = function(_, map)
      map("i", "<CR>", function()
        local e = require("telescope.actions.state").get_selected_entry()
        vim.fn.system("xwallpaper --zoom " .. path .. "/" .. e.value)
        -- vim.fn.system(string.format('wal -q -i %s/%s && xwallpaper --zoom "$(< $HOME/.cache/wal/wal)"', path, e.value))
      end)
      return true
    end,
  }
  if path == "" then
    vim.notify("Wallpaper directory not found!", vim.log.levels.ERROR)
  else
    tb.find_files(opts)
  end
end

function M:reload_module()
  local path = vim.fn.stdpath("config") .. "/lua"
  local function parse_entry(e)
    local mod = e:gsub("%.lua", "")
    mod = mod:gsub("/", ".")
    return mod:gsub("%.init", "")
  end

  local opts = {
    prompt_title = "Nvim Modules",
    cwd = path,
    layout_strategy = self.layout_strategy,

    attach_mappings = function(_, map)
      map("i", "<C-r>", function()
        local e = require("telescope.actions.state").get_selected_entry()
        local mod = parse_entry(e.value)
        require("plenary.reload").reload_module(mod)
        require(mod)
        vim.notify("Reloaded " .. mod, vim.log.levels.INFO)
      end)
      return true
    end,
  }
  tb.find_files(opts)
end
return M
