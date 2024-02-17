local fn = vim.fn
local api = vim.api

local M = {}

---@class Window
---@field combined boolean

---Get current or combined window width
---@param window? Window
---@return number #Window width
function M.get_width(window)
    if window and window.combined == true then
        return vim.opt.co:get()
    end
    return api.nvim_win_get_width(0)
end

---Get attribute value of highlight group
---@param group string Highlight group ID
---@param attr string Attribute name
---@return string
function M.get_hl_attr(group, attr)
    local color = fn.synIDattr(fn.hlID(group), attr)
    return color == "" and nil or color
end

---Clear command-line before printing notification
---@param msg string Message to pass into vim.notify
---@param level? integer|nil One of the values from vim.log.levels
function M.clrscr(msg, level)
    level = level or vim.log.levels.OFF
    api.nvim_feedkeys(":", "nx", true)
    vim.notify(msg, level)
end

return M
