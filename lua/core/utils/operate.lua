local api = vim.api

local M = {}

---Parse specified arguments
--(note: if provided, the first single occurence of the '%' symbol in `cmd` is replaced with `filepath`,
--otherwise `filepath` is appeneded to `cmd`)
---@param cmd string shell command to execute
---@param filepath string filepath location
---@return table|nil #table with two properties: cmd and args
local function gen_cmdict(cmd, filepath)
    if #cmd < 2 then
        return
    end
    local subst_start, _ = string.find(cmd, "%s%%%s?")
    if subst_start then
        cmd = string.format("%s %s %s", cmd:sub(1, subst_start - 1), filepath, cmd:sub(subst_start + 3))
    else
        cmd = string.format("%s %s", cmd, filepath)
    end

    local cmdict = { args = {} }
    cmdict.cmd = string.match(cmd, "%S+")

    if vim.tbl_contains({ "mv", "rm", "shred" }, cmdict.cmd) then
        vim.notify("Aborted due to potentially dangerous operation!", vim.log.levels.WARN)
        return
    end

    local substr, i = string.sub(cmd, #cmdict["cmd"] + 2), 1
    for arg in string.gmatch(substr, "%S+") do
        cmdict.args[i] = arg
        i = i + 1
    end
    return cmdict
end

---@param cmd string
---@param args table
---@param cwd string
function M.jobstart(cmd, args, cwd)
    local buf = api.nvim_create_buf(false, true)
    local lnum = 0
    require("plenary.job")
        :new({
            command = cmd,
            cwd = cwd,
            args = args,
            on_stdout = function(_, data)
                data = string.gsub(data, " ", " ")
                local d = { data }
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
                    api.nvim_buf_delete(buf)
                    print("Done")
                end
            end),
        })
        :sync()
    return api.nvim_buf_is_valid(buf) and buf or nil
end

---Perform shell operation on specified file.
--(note: meant to be used with file browser plugins such as oil)
---@param file string location to file
---@param cwd string
---@param prompt string? input prompt
---@param sp string? sp[lit] direction for output window(default is "sp")
function M:operate(file, cwd, prompt, sp)
    prompt = prompt or "input > "
    sp = sp or "sp"
    local bufnr = nil
    vim.ui.input({
        prompt = prompt,
        completion = "shellcmd",
    }, function(cmd)
        if cmd then
            local cmdict = gen_cmdict(cmd, file)
            local args = {}
            if cmdict and cmdict.args then
                args = cmdict.args
            else
                return
            end
            bufnr = self.jobstart(cmdict.cmd, args, cwd)
        end
    end)
    if bufnr then
        vim.schedule(function()
            api.nvim_buf_set_name(bufnr, "operation_output")
            api.nvim_buf_set_option(bufnr, "ma", false)
        end)
        vim.cmd(string.format("%s | buf %s", sp, bufnr))
    end
end

return M
