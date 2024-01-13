local api = vim.api
local fn = vim.fn
local cmd = api.nvim_create_user_command

cmd("W", "w", {})

cmd("GhBrowse", function(opts)
    local region = function()
        local fpath = fn.fnamemodify(fn.expand("%"), ":.:h") .. "/" .. fn.expand("%:t")
        return opts.range > 0 and string.format("%s:%s-%s", fpath, opts.line1, opts.line2) or fpath
    end
    require("plenary.job")
        :new({
            command = "gh",
            args = { "browse", "--no-browser", region() },
            on_exit = vim.schedule_wrap(function(job, exit_code)
                if exit_code > 0 then
                    for _, line in ipairs(job:stderr_result()) do
                        vim.notify_once(line, vim.log.levels.ERROR)
                    end
                else
                    fn.setreg("+", job:result()[1])
                    print("url copied")
                end
            end),
        })
        :start()
end, {
    range = true,
    desc = "Copy github url for selected region of current file",
})

cmd("Msg", function()
    local bufnr = api.nvim_create_buf(false, true)
    api.nvim_buf_call(bufnr, function()
        vim.cmd([[
            put =execute('messages') |
            %s:\n:\r:g
        ]])
    end)
    vim.cmd("sbuf + " .. bufnr)
end, { desc = "Redirect and open :messages output in a separate readonly buffer" })

cmd("Transparent", function()
    local groups = {
        "StatusLine",
        "StatusLineNC",
        "StatusLineImp",
        "StatusLineInd",
        "StatusLineDiagnosticError",
        "StatusLineDiagnosticHint",
        "StatusLineDiagnosticInfo",
        "StatusLineDiagnosticWarn",
        "LineNr",
        "CursorLineNr",
        "CursorLine",
        "SignColumn",
        "GitGutterAdd",
        "GitGutterChange",
        "GitGutterDelete",
        "Normal",
        "NormalFloat",
        "FloatBorder",
    }
    for _, hlg in ipairs(groups) do
        vim.cmd.highlight(hlg .. " guibg=NONE")
    end
end, { desc = "Disable background color for certain hlgroups" })

cmd("Splitree", function()
    local fpath = vim.fn.expand("%:p")
    local f = vim.loop.fs_statfs(fpath)

    if not f or f.type ~= 26 then
        vim.notify("Not a valid file", 4)
        return
    end

    local url = "ft://" .. fpath
    local fname = fn.fnamemodify(fpath, ":t")
    local ns_id = api.nvim_create_namespace("core.usrcmd.splitree")

    local viewfunc = function(bufnr)
        vim.cmd("vsp | buf " .. bufnr)

        --TODO: Look for better optimized way to do this
        local subdir, _ = string.gsub(fpath, vim.loop.cwd() .. "/", "")
        for dir in string.gmatch(subdir, "[%a%s_%.%-]+%/") do
            vim.cmd(string.format("call search('%s', 'zW')", dir))
        end

        vim.cmd(string.format("call search('%s', 'zW') | exec 'norm zz'", fname))
    end

    local createfunc = vim.schedule_wrap(function()
        local bufnr = require("core.utils.jobwrite").jobstart("tree", {
            "-naF",
            "--gitignore",
            "-I",
            ".git",
        }, vim.loop.cwd())

        if bufnr then
            vim.schedule(function()
                require("core.utils.display").view_buf(bufnr, viewfunc)
                local pos = fn.getpos(".")
                api.nvim_buf_add_highlight(bufnr, ns_id, "PmenuSel", pos[2] - 1, pos[3] - 1, -1)
                api.nvim_buf_set_option(bufnr, "ft", "filetree")
                api.nvim_buf_set_option(bufnr, "ma", false)
                api.nvim_buf_set_name(bufnr, url)
            end)
        end
    end)

    require("core.utils.display"):init(url, viewfunc, createfunc)
end, { desc = "Hierarchically display files under cwd relative to current file" })
