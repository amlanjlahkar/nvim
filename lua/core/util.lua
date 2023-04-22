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
  ---@class Cmd
  ---@field cmd string Command to run
  ---@field iptr boolean|string Interpreter to use for executing byte compiled code or `true` if `cmd` is an interpreter

  ---@param cmd Cmd
  ---@param args table Arguments to pass to `cmd`
  ---@param outfile? string Location to use for generated output file
  local function exec(cmd, args, outfile)
    if cmd.iptr and type(cmd.iptr) == "boolean" then
      vim.cmd.terminal(string.format("%s %s", cmd.cmd, fn.expand("%:p")))
      return
    end

    local logfile
    if outfile then
      logfile = outfile .. "_error.log"
      if not outfile:match("/tmp/") then
        logfile = "/tmp/" .. logfile
      end
    end

    table.insert(args, fn.expand("%:p"))
    require("plenary.job")
      :new({
        command = cmd.cmd,
        args = args,
        on_stderr = function(_, data)
          local file = assert(io.open(logfile, "a"))
          file:write(data, "\n")
          file:close()
        end,
        on_exit = vim.schedule_wrap(function(_, code)
          if code > 0 then
            vim.cmd("view +setl\\ nomodifiable " .. logfile)
          else
            vim.ui.input({ prompt = "Arguments to pass: " }, function(input)
              if type(cmd.iptr) == "string" and cmd.iptr then
                vim.cmd.terminal(string.format("%s %s %s", cmd.iptr, outfile, input))
              else
                vim.cmd.terminal(string.format("%s %s", outfile, input))
              end
            end)
          end
        end),
      })
      :start()
  end

  local out = string.format("/tmp/%s", fn.expand("%:t:r"))
  local def = {
    lua = function()
      exec({ cmd = "luac", iptr = "lua" }, { "-o", out }, out)
    end,
    python = function()
      exec({ cmd = "python", iptr = true }, _)
    end,
    c = function()
      exec({ cmd = "clang", iptr = false }, { "-Wall", "-std=c17", "-lm", "-o", out }, out)
    end,
    cpp = function()
      exec({ cmd = "clang++", iptr = false }, { "-Wall", "-std=c++20", "-o", out }, out)
    end,
    java = function()
      local _out = fn.expand("%:t:r")
      exec({ cmd = "javac", iptr = "java" }, {}, _out)
    end,
  }

  for lang, func in pairs(def) do
    if filetype == lang then
      return func
    end
  end
  return nil
end

---@param path string Path to parent module
---@param exclude table Child modules to exclude
---Recursively load modules(under config) from a specified path
function M.req(path, exclude)
  local modname = function(m) return fn.fnamemodify(m, ":r") end
  table.insert(exclude, "init")
  local req = fn.readdir(fn.stdpath("config") .. "/lua/" .. path, function(m)
    return vim.tbl_contains(exclude, modname(m)) and 0 or 1
  end)
  for _, m in ipairs(req) do
    local modpath = path:gsub(".*/lua/", ""):gsub("/", ".")
    require(modpath .. "." .. modname(m))
  end
end

return M
