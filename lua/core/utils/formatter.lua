local is_avail, job = pcall(require, "plenary.job")
if not is_avail then
    return
end

local function err(msg)
    return vim.notify(msg, vim.log.levels.ERROR)
end

local formatprg = {
    stylua = {
        ft = "lua",
        args = { "--verify" },
    },
    shfmt = {
        ft = { "sh", "bash" },
        args = { "-i", "2", "-ci", "-bn" },
    },
    prettier = {
        ft = { "javascript", "css", "html" },
        args = { "--write" },
    },
}

local function format(cmd, opts)
        table.insert(opts.args, vim.fn.expand("%:p"))

        job:new({
            command = cmd,
            args = opts.args,
            on_exit = vim.schedule_wrap(function(data, code)
                if code > 0 then
                    err(data["_stderr_results"][1])
                end
            end),
        }):sync()

        vim.cmd("edit!")
end

local M = {
    format = function()
        for prg, opts in pairs(formatprg) do
            if type(opts.ft) == "string" then
                opts.ft = { opts.ft }
            end
            ---@diagnostic disable-next-line param-type-mismatch
            if vim.tbl_contains(opts.ft, vim.bo.ft) then
                assert(
                    vim.fn.executable(prg) == 1,
                    string.format('Couldn\'t format buffer(executable "%s" not found!)', opts.cmd)
                )
                format(prg, opts)
                return
            end
        end
        local ft = vim.bo.ft ~= "" and vim.bo.ft or "unknown filetype"
        err(string.format("No formatter defined for %s", ft))
    end,
}

return M
