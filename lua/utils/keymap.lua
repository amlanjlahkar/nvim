--[[
    A wrapper around vim.keymap.set for conveniently defining keybinds.
    Originally written by glepnir (https://github.com/glepnir/cosynvim/blob/main/lua/core/keymap.lua).
--]]

local M = {}
local opts = {}

function opts:new(instance)
    instance = instance
        or {
            options = {
                silent = true,
                nowait = false,
                expr = false,
                remap = false,
            },
        }
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function M.nosilent(opt)
    return function()
        opt.silent = false
    end
end

function M.nowait(opt)
    return function()
        opt.nowait = true
    end
end

function M.expr(opt)
    return function()
        opt.expr = true
    end
end

function M.remap(opt)
    return function()
        opt.remap = true
    end
end

function M.new_opts(...)
    local args = { ... }
    local o = opts:new()

    if #args == 0 then
        return o.options
    end

    for _, arg in pairs(args) do
        if type(arg) == "string" then
            o.options.desc = arg
        elseif type(arg) == "number" then
            o.options.buffer = arg
        else
            arg(o.options)()
        end
    end
    return o.options
end

function M.cmd(str)
    return "<Cmd>" .. str .. "<CR>"
end

-- visual mode
function M.cu(str)
    return "<C-u><cmd>" .. str .. "<CR>"
end

local function keymap_set(mode, tbl)
    vim.validate("tbl", tbl, "table")
    local len = #tbl

    assert(len >= 2, "Keymap must have rhs")

    local options = len == 3 and tbl[3] or M.new_opts()

    vim.keymap.set(mode, tbl[1], tbl[2], options)
end

local function map(mode)
    return function(tbl)
        vim.validate("tbl", tbl, "table")
        if type(tbl[1]) == "table" then
            for _, v in pairs(tbl) do
                keymap_set(mode, v)
            end
        else
            keymap_set(mode, tbl)
        end
    end
end

M.nmap = map("n")
M.imap = map("i")
M.cmap = map("c")
M.vmap = map("v")
M.xmap = map("x")
M.tmap = map("t")
M.smap = map("s")
M.ismap = map({ "i", "s" })
M.nxmap = map({ "n", "x" })
M.xomap = map({ "x", "o" })

return M
