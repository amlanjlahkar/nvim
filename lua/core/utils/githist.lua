--[[
    Search for regex pattern in file history belonging to git repository.
    -   Use telescope for picking file(s)
    -   Load results into quickfix list on success
--]]

local uv = vim.loop
local api = vim.api
local fn = vim.fn
local insert = table.insert
local format = string.format

local M = {}

---Check if path is a valid git repository
---@param path string Absolute path to repository
---@return boolean
function M.is_gitrepo(path)
    if fn.system("git rev-parse -C " .. path) and vim.v.shell_error > 0 then
        vim.notify(path .. " is not a valid git repository!", 4)
        return false
    end
    return true
end

---Extract file history from commit
---@param cwd string Path to git repository
---@param commit string Commit hash
---@param file string File path
---@return table # File lines from specified revision
function M.get_blob_lines(cwd, commit, file)
    local cmd = format("git -C %s show %s:%s", cwd, commit, file)
    local tmp = io.popen(cmd, "r")
    local lines = {}
    if tmp then
        for line in tmp:lines() do
            insert(lines, line)
        end
        tmp:close()
        return lines
    end
    return {}
end

---Create and append buffer into quickfix list
---@param cobj table Commit object
---@param pattern string Regex to search for in buffer
---@param lines table|function Lines to feed into buffer
---@return number # Buffer id of newly created quickfix entry
function M.qfadd(cobj, pattern, lines)
    local qbuf = api.nvim_create_buf(false, true)
    local bufname = format("glog_%s~%s_%s", string.sub(cobj.hash, 1, 7), cobj.date, cobj.file)
    local query = format("/%s/gj %%", pattern)
    api.nvim_buf_call(qbuf, function()
        api.nvim_buf_set_name(qbuf, bufname)
        api.nvim_buf_set_lines(qbuf, 0, -1, false, lines)
        pcall(vim.cmd.vimgrepadd, query)
    end)
    return qbuf
end

---Create quickfix list
---@param cwd string Path to git repository
---@param pattern string Regex to search for in file history
---@param files table Files to search against
function M.setqf(cwd, pattern, files)
    --stylua: ignore
    local def_args = {
        "-C", cwd,
        "log",
        "--name-only",
        "--date", "format:%Y-%m-%d_%H:%M:%S",
        "-G", pattern
    }
    table.move(files, 1, #files, #def_args + 1, def_args)

    local cobjs = {}
    local cid = 0

    local stdout = uv.new_pipe()
    local proc

    proc = uv.spawn("git", {
        args = def_args,
        stdio = { nil, stdout, nil },
    }, function(code)
        assert(code == 0, "Invalid arguments received!")
        stdout:read_stop()
        proc:close()
        vim.schedule(function()
            if #cobjs >= 1 then
                if Qfid == fn.getqflist({ id = 0 }).id then
                    fn.setqflist({}, "r", { id = Qfid, items = {} })
                else
                    fn.setqflist({}, " ")
                end
                if _G["QBuffers"] then
                    vim.cmd("sil bd " .. table.concat(_G["QBuffers"], " "))
                end

                fn.setqflist({}, "a", { title = "Git history:" .. pattern })
                Qfid = fn.getqflist({ id = 0 }).id
                QBuffers = {}

                for _, obj in pairs(cobjs) do
                    local buf = M.qfadd(obj, pattern, M.get_blob_lines(cwd, obj.hash, obj.file))
                    insert(QBuffers, buf)
                end
            else
                vim.notify(format("Pattern '%s' not found!", pattern), 4)
            end
        end)
    end)

    uv.read_start(stdout, function(_, data)
        local nidx = 1
        while data do
            local eol = string.find(data, "\n", nidx, true)
            if not eol then
                break
            end
            local line = string.sub(data, nidx, eol - 1)
            local hash = string.match(line, "commit%s+([%x]+)")
            local date = string.match(line, "Date:%s+([%x%-_:]+)")
            if hash then
                cid = cid + 1
                cobjs[cid] = { hash = hash }
            end
            if date then
                cobjs[cid].date = date
            end
            if vim.tbl_contains(files, line) then
                if cobjs[cid].file then
                    cobjs[cid + 1] = vim.deepcopy(cobjs[cid])
                    cobjs[cid + 1].file = line
                    cid = cid + 1
                else
                    cobjs[cid].file = line
                end
            end
            nidx = eol + 1
        end
    end)
end

return M
