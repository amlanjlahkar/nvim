-- Originally written by glepnir
-- https://github.com/glepnir/cosynvim/blob/main/lua/core/keymap.lua

local keymap = {}
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

function keymap.nosilent(opt)
    return function()
        opt.silent = false
    end
end

function keymap.nowait(opt)
    return function()
        opt.nowait = true
    end
end

function keymap.expr(opt)
    return function()
        opt.expr = true
    end
end

function keymap.remap(opt)
    return function()
        opt.remap = true
    end
end

function keymap.new_opts(...)
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

function keymap.cmd(str)
    return "<cmd>" .. str .. "<CR>"
end

-- visual
function keymap.cu(str)
    return "<C-u><cmd>" .. str .. "<CR>"
end

local function keymap_set(mode, tbl)
    vim.validate("tbl", tbl, "table")
    local len = #tbl

    assert(len >= 2, "Keymap must have rhs")

    local options = len == 3 and tbl[3] or keymap.new_opts()

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

keymap.nmap = map("n")
keymap.imap = map("i")
keymap.cmap = map("c")
keymap.vmap = map("v")
keymap.xmap = map("x")
keymap.tmap = map("t")
keymap.smap = map("s")
keymap.ismap = map({ "i", "s" })
keymap.nxmap = map({ "n", "x" })
keymap.xomap = map({ "x", "o" })

return keymap
