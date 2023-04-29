local fn = vim.fn
local fnmod = fn.fnamemodify

local M = {}
---Recursively search for files under path
---@param path string? Namespace path(defaults to current file's parent path)
---@param exclude table|function? Modules to exclude
---@param depth integer? Maximum depth to scan for nested modules
---@return table # Formatted file paths
function M.req(path, exclude, depth)
  path = path and fn.stdpath("config") .. "/lua/" .. path or fn.expand("%:h")
  if exclude and type(exclude) == "table" then
    table.insert(exclude, "init")
  else
    exclude = { "init" }
  end
  local modname = function(m)
    local child = m:gsub(string.format("^%s/", path), "")
    if child == "init.lua" then
      return fnmod(path, ":t")
    end
    return child:find("init") and fnmod(child, ":h"):gsub("/", ".") or fnmod(child, ":r"):gsub("/", ".")
  end
  local mods = {}
  require("plenary.scandir").scan_dir(path, {
    depth = depth,
    on_insert = function(m)
      if fnmod(m, ":e") ~= "lua" then
        return
      elseif not vim.tbl_contains(exclude, modname(m)) then
        local root = fnmod(path, ":t")
        if modname(m) == root then
          table.insert(mods, modname(m))
        else
          table.insert(mods, string.format("%s.%s", root, modname(m)))
        end
      end
    end,
  })
  return mods
end

return M.req
