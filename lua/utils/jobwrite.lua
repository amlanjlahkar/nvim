local api = vim.api
local buf_is_valid = api.nvim_buf_is_valid
local buf_set_lines = api.nvim_buf_set_lines
local buf_del = api.nvim_buf_delete

local M = {}

---Define a new job
---@param cmd string Command to execute
---@param args table Arguments to pass to the command
---@param cwd string Current working directory to set for `cmd`
---@return integer|nil, table|nil #Buffer handle and job object
function M.define(cmd, args, cwd)
    local is_avail, plenary_job = pcall(require, "plenary.job")
    if not is_avail then
        vim.notify("plenary.job module not found!", 4)
        return
    end
    local buf = api.nvim_create_buf(false, true)
    local lnum = 0

    return buf,
        plenary_job:new({
            command = cmd,
            cwd = cwd,
            args = args,
            on_stdout = function(_, data)
                local d = { (data:gsub(" ", " ")) }
                lnum = lnum + 1
                vim.schedule(function()
                    if buf_is_valid(buf) then
                        buf_set_lines(buf, lnum, lnum, false, d)
                    end
                end)
            end,

            on_stderr = vim.schedule_wrap(function(_, data, self)
                if data then
                    vim.notify(data, vim.log.levels.ERROR)
                    if buf_is_valid(buf) then
                        buf_del(buf, { unload = false })
                    end
                    self:shutdown()
                end
            end),

            on_exit = vim.schedule_wrap(function(j, code)
                if code == 0 and #j:result() < 1 then
                    vim.notify("Done", vim.log.levels.INFO)
                    buf_del(buf, { unload = false })
                elseif buf_is_valid(buf) then
                    buf_set_lines(buf, 0, 1, true, {})
                end
            end),
        })
end

return M
