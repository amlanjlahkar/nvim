local fn = vim.fn
local api = vim.api

local M = {}

function M.buf_preview_maker(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  require("plenary.job")
    :new({
      command = "file",
      args = { "--mime-type", "-b", filepath },
      on_exit = function(j)
        local mime_type = vim.split(j:result()[1], "/")[1]
        if mime_type == "text" then
          require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
        else
          vim.schedule(function()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
          end)
        end
      end,
    })
    :sync()
end

function M.use_theme(picker_opts)
  local theme = "dropdown"
  local opts = {
    layout_config = {
      anchor = "CENTER",
      width = 0.4,
      height = 0.8,
    },
  }
  if picker_opts then
    for k, v in pairs(picker_opts) do
      opts[k] = v
    end
  end
  return require("telescope.themes")["get_" .. theme](opts)
end

function M.pick(type)
  local t = setmetatable({}, {
    __index = function(_, picker)
      return function(use, opts)
        local picker_opts = use == false and opts or M.use_theme(opts)
        require(type)[picker](picker_opts)
      end
    end,
  })
  return t
end

local tb = M.pick("telescope.builtin")

function M.get_nvim_conf()
  local opts = {
    prompt_title = "Neovim Config",
    cwd = fn.stdpath("config"),
  }
  tb.find_files(_, opts)
end

function M.get_relative_file()
  local opts = {
    prompt_title = "Relative Files",
    cwd = fn.expand("%:p:h"),
  }
  tb.find_files(_, opts)
end

function M.get_dwots()
  local dothome = fn.finddir("~/dwots/")
  local opts = {
    prompt_title = "Dotfiles",
    cwd = dothome,
    find_command = { "fd", "--hidden", "--exclude", ".git", "--type", "file" },
  }
  if dothome == "" then
    vim.notify("Direcetory dwots not found!", vim.log.levels.ERROR)
  else
    tb.find_files(_, opts)
  end
end

function M.set_bg()
  local path = fn.finddir("~/media/pictures/wallpapers/")
  local opts = {
    prompt_title = "Choose Wallpaper",
    cwd = path,
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
    require("telescope").extensions.media.media(opts)
  end
end

function M.reload_module()
  local path = vim.fn.stdpath("config") .. "/lua"
  local function parse_entry(e)
    local mod = e:gsub("%.lua", "")
    mod = mod:gsub("/", ".")
    return mod:gsub("%.init", "")
  end

  local opts = {
    prompt_title = "Nvim Modules",
    cwd = path,

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
  tb.find_files(_, opts)
end

return M
