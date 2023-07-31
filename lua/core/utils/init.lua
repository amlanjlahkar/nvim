local fn = vim.fn
local api = vim.api

local M = {}

---@class Window
---@field combined boolean Decide whether to return combined or current window width
---Get width of all the visible windows combined(which is equivalent to the width
--of the opened neovim instance) if window.combined is true, else width of the current window
---@param window Window
---@return number
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

---Get attribute value of specified highlight group
---@param group string Highlight group ID
---@param attr string Attribute name
---@return string
function M.get_hl_attr(group, attr)
    local color = fn.synIDattr(fn.hlID(group), attr)
    return color == "" and nil or color
end

return M
