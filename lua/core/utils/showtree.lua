local fn = vim.fn
local api = vim.api

local M = {}

function M.showtree()
    local fpath = vim.fn.expand("%:p")
    local f = vim.loop.fs_statfs(fpath)

    if not f or f.type ~= 26 then
        vim.notify("Not a valid file", 4)
        return
    end

    local url = "ft://" .. fpath
    local fname = vim.fn.fnamemodify(fpath, ":t")
    local ns_id = api.nvim_create_namespace("core.utils.showtree")

    local function view_buf(buf)
        local winnr = fn.bufwinnr(buf)
        if winnr < 0 then
            vim.cmd("buf " .. buf)

            local subdir, _ = string.gsub(fpath, vim.loop.cwd() .. "/", "")
            for s in string.gmatch(subdir, "[%a%s_%.%-]+%/") do
                vim.cmd(string.format("call search('%s', 'zW')", s))
            end

            vim.cmd(string.format("call search('%s', 'zW') | exec 'norm zz'", fname))
        else
            vim.cmd(string.format("exec '%s wincmd w'", winnr))
        end
    end

    local create_buf = vim.schedule_wrap(function()
        local buf =
            require("core.utils.operate").jobstart("tree", { "-naF", "--gitignore", "-I", ".git" }, vim.loop.cwd())
        vim.schedule(function()
            view_buf(buf)
            local pos = fn.getpos(".")
            api.nvim_buf_add_highlight(buf, ns_id, "PmenuSel", pos[2] - 1, pos[3] - 1, -1)
            api.nvim_buf_set_option(buf, "ma", false)
            api.nvim_buf_set_name(buf, url)
        end)
    end)

    if fn.bufexists(url) < 1 then
        create_buf()
        return
    end

    local bufnr = fn.bufnr(url)
    if api.nvim_buf_is_loaded(bufnr) then
        view_buf(bufnr)
    else
        vim.cmd("bwipe " .. bufnr)
        create_buf()
    end
end

return M
