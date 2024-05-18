local api = vim.api
local fn = vim.fn

local M = {}

---View the specified buffer.
---@param bufnr integer Buffer number
---@param viewfunc function Callback to invoke for view operation
M.view_buf = function(bufnr, viewfunc)
    local winnr = fn.bufwinnr(bufnr)
    if winnr < 0 then
        viewfunc(bufnr)
    else
        vim.cmd(string.format("exec '%s wincmd w'", winnr))
    end
end

---View or Create buffer when necessary.
---@param url string Custom url to use as buffer name
---@param viewfunc function Function to be passed into `view_buf` as parameter
---@param createfunc function Callback to invoke for buffer creation
M.init = function(self, url, viewfunc, createfunc)
    if fn.bufexists(url) < 1 then
        createfunc()
        return
    end

    local bufnr = fn.bufnr(url)

    if api.nvim_buf_is_loaded(bufnr) then
        self.view_buf(bufnr, viewfunc)
    else
        api.nvim_buf_delete(bufnr, { force = true, unload = false })
        createfunc()
    end
end

return M
