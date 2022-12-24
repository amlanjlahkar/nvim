local fn = vim.fn
local api = vim.api

local M = {}

--- Get window width.
-- @param window Table with a single field.
-- @field window.combined  Boolean to decide whether to return combined or current window width.
-- @return Width of all the visible windows combined(current view) if window.combined is true, else width of the current window.
util.get_width = function(window)
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

--- Get attribute value of given highlight group.
-- @param group Highlight group ID.
-- @param attr Attribute name
-- @return Attribute value
util.get_hl_attr = function(group, attr)
  local color = fn.synIDattr(fn.hlID(group), attr)
  return color == "" and nil or color
end

--- Small set of functions to compile/interprete code for certain langs.
-- @param filetype Language filetype.
-- @return Function for given filetype if it's present, else nil.
util.test_code = function(filetype)
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
