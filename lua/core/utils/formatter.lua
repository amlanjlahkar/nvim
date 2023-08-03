local is_avail, job = pcall(require, "plenary.job")
if not is_avail then
    return
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
        ft = { "javascript", "css", "html", "json" },
        args = { "--write" },
    },
}

local function format(cmd, opts)
    local view = vim.fn.winsaveview()
    table.insert(opts.args, vim.fn.expand("%:p"))
    job:new({
        command = cmd,
        args = opts.args,
        on_exit = vim.schedule_wrap(function(data, code)
            if code > 0 then
                error(data["_stderr_results"][1])
            end
            vim.cmd("edit!")
            vim.fn.winrestview(view)
        end),
    }):start()
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
        if vim.bo.ft then
            error(string.format("No formatter defined for %s", vim.bo.ft))
        else
            error("Couldn't format buffer(unknown filetype)")
        end
    end,
}

return M
