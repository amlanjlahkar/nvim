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
  local function compile_and_run(cmd, args, outfile)
    local logfile, exit_code = nil, 0
    if outfile == nil then outfile = args[#args] end
    if outfile:match("/tmp/") then
      logfile = outfile .. "_error.log"
    else
      logfile = "/tmp/" .. outfile .. "_error.log"
    end
    table.insert(args, fn.expand("%:p"))
    require("plenary.job"):new({
      command = cmd,
      args = args,
      on_stderr = function(_, data)
        local file = assert(io.open(logfile, "a"))
        file:write(data, "\n")
        file:close()
        exit_code = 2
      end,
    }):sync()
    if exit_code > 0 then
      vim.cmd("view +setl\\ nomodifiable " .. logfile)
    else
      vim.ui.input({ prompt = "Arguments to pass: " }, function(input)
        vim.cmd.terminal(string.format("%s %s %s", cmd, outfile, input))
      end)
    end
  end

  local def = {
    lua = function() vim.cmd.terminal("lua %") end,
    python = function() vim.cmd.terminal("python %") end,
    c = function()
      local outfile = string.format("/tmp/%s", fn.expand("%:t:r"))
      compile_and_run("gcc", { "-lm", "-o", outfile })
    end,
    cpp = function()
      local outfile = string.format("/tmp/%s", fn.expand("%:t:r"))
      compile_and_run("g++", { "-o", outfile })
    end,
    java = function()
      local outfile = fn.expand("%:t:r")
      compile_and_run("javac", {}, outfile)
    end,
  }

  for lang, func in pairs(def) do
    if filetype == lang then
      return func
    end
  end
  return nil
end

return M
