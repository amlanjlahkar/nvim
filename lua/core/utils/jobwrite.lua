local api = vim.api

local M = {}

---Start a job and write its output to a temporary buffer
---@param cmd string Command to execute
---@param args table Arguments to pass to the command
---@param cwd string Current working directory to set for `cmd`
---@return integer|nil #Buffer handle or nil if no output
function M.jobstart(cmd, args, cwd)
    local is_avail, plenary_job = pcall(require, "plenary.job")
    if not is_avail then
        vim.notify("plenary.job module not found!", 4)
        return
    end
    local buf = api.nvim_create_buf(false, true)
    local lnum = 0

    plenary_job
        :new({
            command = cmd,
            cwd = cwd,
            args = args,
            on_stdout = function(_, data)
                local d = { (data:gsub(" ", " ")) }
                lnum = lnum + 1
                vim.schedule(function()
                    api.nvim_buf_set_lines(buf, lnum, lnum, false, d)
                end)
            end,
            on_exit = vim.schedule_wrap(function(j, code)
                -- TODO: better error output
                if code > 0 then
                    vim.print(j:result())
                    return
                end
                if #j:result() < 1 then
                    api.nvim_buf_delete(buf, { unload = false })
                    print("Done")
                end
            end),
        })
        :sync()
    return api.nvim_buf_is_valid(buf) and buf or nil
end

return M
