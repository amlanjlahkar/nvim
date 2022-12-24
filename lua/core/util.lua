local fn = vim.fn
local api = vim.api

local M = {}

---@class Window
---@field combined boolean Decide whether to return combined or current window width
---@param window Window
---@return number
---Get width of all the visible windows combined(which is equivalent to the width
---of the opened neovim instance) if window.combined is true, else width of the current window
function M.get_width(window)
  local width = 0
  if window == nil or window.combined then
    for i = 1, fn.winnr("$") do
      local id = fn.win_getid(i)
      local pos = api.nvim_win_get_position(id)
      if fn.tabpagenr("$") == 1 and pos[1] ~= 0 then
        goto continue
      end
      width = width + api.nvim_win_get_width(id)
      ::continue::
    end
  else
    width = api.nvim_win_get_width(0)
  end
  return width
end

---@param group string Highlight group ID
---@param attr string Attribute name
---@return string
---Get attribute value of given highlight group
function M.get_hl_attr(group, attr)
  local color = fn.synIDattr(fn.hlID(group), attr)
  return color == "" and nil or color
end

---@param filetype string Language filetype
---@return function | nil
---Small set of functions to compile/interprete code for certain langs
function M.test_code(filetype)
  local function gcc_compile()
    local fpath = fn.expand("%:p")
    local outfile = string.format("/tmp/%s", fn.expand("%:t:r"))
    local exit_code
    require("plenary.job"):new({
      command = "gcc",
      args = { "-lm", "-lstdc++", "-o", outfile, fpath },
      on_stderr = function()
        exit_code = 2
      end,
    }):sync()
    return exit_code and exit_code or outfile
  end

  local function gcc_run()
    local out = gcc_compile()
    if type(out) == "number" then
      vim.notify("Compilation error!", vim.log.levels.ERROR)
    else
      vim.cmd.terminal(out)
    end
  end

  local def = {
    lua = function() vim.cmd.terminal("lua %") end,
    python = function() vim.cmd.terminal("python %") end,
    c = function() gcc_run() end,
    cpp = function() gcc_run() end,
  }

  local is_defined = 0
  for lang, cmd in pairs(def) do
    if filetype == lang then
      is_defined = 1
      return cmd
    end
  end
  return is_defined < 1 and nil
end

return M
