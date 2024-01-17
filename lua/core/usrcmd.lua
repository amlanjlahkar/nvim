local api = vim.api
local fn = vim.fn
local uv = vim.loop
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
    local fpath = fn.expand("%:p")
    local f = uv.fs_statfs(fpath)

    if not f or f.type ~= 26 then
        vim.notify("Not a valid file", 4)
        return
    end

    local markname = "f"
    local url = "ft://" .. fpath
    local ns_id = api.nvim_create_namespace("core.usrcmd.splitree")

    local draw_win = function(bufnr, mark)
        api.nvim_buf_add_highlight(bufnr, ns_id, "PmenuSel", mark[1] - 1, mark[2], -1)
        api.nvim_buf_set_option(bufnr, "ma", false)
        vim.cmd("vsp | buf " .. bufnr)
        api.nvim_win_set_option(0, "stc", "")
        api.nvim_win_set_option(0, "nu", false)
        api.nvim_win_set_option(0, "rnu", false)
        api.nvim_win_set_cursor(0, mark)
        vim.cmd("wincmd p")
    end

    local viewfunc = function(bufnr)
        local mark = api.nvim_buf_get_mark(bufnr, markname)

        if mark[1] > 0 and mark[2] > 0 then
            draw_win(bufnr, mark)
        else
            require("core.utils").clrscr("Loading filetree...", 2)
            vim.defer_fn(function()
                draw_win(bufnr, api.nvim_buf_get_mark(bufnr, markname))
            end, 5000)
        end
    end

    local createfunc = vim.schedule_wrap(function()
        local bufnr = require("core.utils.jobwrite").jobstart("tree", {
            "-anlF",
            "--dirsfirst",
            "--gitignore",
            "-I",
            ".git",
        }, uv.cwd())

        if bufnr then
            vim.schedule(function()
                local subdirs = vim.split(fn.fnamemodify(fn.resolve(fpath), ":."), "/", { plain = true })

                local idx = 1

                api.nvim_buf_attach(bufnr, false, {
                    on_lines = function(_, _, _, _, cfline)
                        local line = api.nvim_buf_get_lines(bufnr, cfline, cfline + 1, false)[1]

                        local cfname_idx = (line:find("[%w%.%_]"))

                        local cfname = line:sub(cfname_idx)

                        local is_same = (cfname:find(string.format("^%s[/=|%%*]?$", subdirs[idx])))

                        if cfname == subdirs[idx] or is_same then
                            if idx == #subdirs then
                                local depth = cfname_idx and math.floor(((cfname_idx - 1) / 5) - 1) or -1

                                if depth ~= #subdirs then
                                    idx = 0
                                else
                                    api.nvim_buf_set_mark(bufnr, markname, cfline + 1, cfname_idx - 1, {})
                                    return true
                                end
                            end

                            idx = idx + 1
                        end
                    end,
                })
            end)

            api.nvim_buf_set_name(bufnr, url)
            api.nvim_buf_set_option(bufnr, "ft", "filetree")

            vim.defer_fn(function()
                viewfunc(bufnr)
            end, 300)
        end
    end)

    require("core.utils.display"):init(url, viewfunc, createfunc)
end, { desc = "Hierarchically display files under cwd relative to current file" })
