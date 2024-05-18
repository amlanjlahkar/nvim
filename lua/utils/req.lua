local fn = vim.fn
local uv = vim.loop
local fnmod = fn.fnamemodify

local function pathmod(root_path, file_path)
    local child = file_path:gsub(string.format("^%s/", root_path), ""):gsub("%/init.lua", "")
    if child == "init.lua" then
        return fnmod(root_path, ":t")
    end
    return child:find("init") and fnmod(child, ":h"):gsub("/", ".") or fnmod(child, ":r"):gsub("/", ".")
end

local M = {}
---Recursively search for files under path
---@param path string? Namespace path(defaults to current file's parent path)
---@param exclude table? Modules to exclude
---@return table # Formatted file paths
function M.req(path, exclude)
    local apath = path and fn.stdpath("config") .. "/lua/" .. path or fn.expand("%:h")

    if exclude and type(exclude) == "table" then
        table.insert(exclude, "init")
    else
        exclude = { "init" }
    end

    local submodules = {}
    local subdir = vim.tbl_flatten({ apath })

    repeat
        local current_dir = table.remove(subdir, 1)
        local fd = assert(uv.fs_scandir(current_dir))
        if fd then
            while true do
                local fname, ftype = uv.fs_scandir_next(fd)
                if fname == nil then
                    break
                elseif ftype == "directory" then
                    table.insert(subdir, apath .. "/" .. fname)
                else
                    local fpath = vim.fs.find(fname, { path = apath })[1]
                    local module = pathmod(apath, fpath)
                    if fnmod(fpath, ":e") ~= "lua" then
                        goto continue
                    elseif not vim.tbl_contains(exclude, module) then
                        local root = fnmod(apath, ":t")
                        if module == root then
                            table.insert(submodules, module)
                        else
                            table.insert(submodules, string.format("%s.%s", root, module))
                        end
                    end
                end
                ::continue::
            end
        end
    until #subdir == 0

    return submodules
end

return M
