local api = vim.api
local fn = vim.fn

local M = {}

---Generate a table by parsing argument strings
--(note: if provided, the first single occurence of the '%' symbol in `cmd` is replaced with `filepath`,
--otherwise `filepath` is appeneded to `cmd`)
---@param cmd string Shell command to execute
---@param filepath string Filepath location
---@return table|nil #table with two properties - cmd and args
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

---Interactively perform shell operation on specified file.
--(note: meant to be used with file browser plugins such as oil)
---@param file string Filepath location
---@param cwd string Current working directory to set for `cmd`
---@param prompt string? Input prompt
---@param sp string? sp[lit] direction for output window(default is "sp")
function M:operate(file, cwd, prompt, sp)
    prompt = prompt or "input > "
    sp = sp or "sp"

    local viewfunc = function(bufnr)
        vim.cmd(string.format("%s | buf %s", sp, bufnr))
    end

    local createfunc = vim.schedule_wrap(function(cmdict, args, url)
        local bufnr = require("core.utils.jobwrite").jobstart(cmdict.cmd, args, cwd)
        if bufnr then
            vim.schedule(function()
                require("core.utils.display").view_buf(bufnr, viewfunc)
                api.nvim_buf_set_option(bufnr, "ma", false)
                api.nvim_buf_set_name(bufnr, url)
            end)
        end
    end)

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

            local url = string.format(
                "op://%s/%s/%s",
                cwd:gsub("/$", ""),
                fn.fnamemodify(file, ":t"),
                cmd:gsub("[%s%-]+", "%%")
            )

            require("core.utils.display"):init(url, viewfunc, function()
                createfunc(cmdict, args, url)
            end)
        end
    end)
end

return M
