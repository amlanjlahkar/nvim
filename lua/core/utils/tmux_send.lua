--[[
    Unresolved caveats:
        - window with specified name already exists
        - foreground process currently being executed in target window
        - missing optimal shell completion while reading input
--]]

local call = vim.fn.system
local format = string.format
local clrscr = require("core.utils").clrscr

local M = {}

function M.tmux_send(session, winid, query)
    local exit_code = 0

    --stylua: ignore
    require("plenary.job"):new({
        command = "tmux",
        args = { "send", "-R", "-t", session .. ":" .. winid, query, "C-m" },
        on_exit = function(_, code)
            exit_code = code
        end,
    }):sync()

    return exit_code
end

function M.validate(query)
    if not query or query == "" then
        return nil
    end

    local insecure_cmds = { "sudo", "doas", "mv", "rm", "shred" }

    local cmd = query:match("%w+")

    if vim.fn.executable(cmd) < 1 then
        clrscr("Command not found(note: aliases are not allowed due to possible security risks)", 4)
        return nil
    elseif vim.tbl_contains(insecure_cmds, cmd) then
        clrscr("Aborted due to potentially dangerous command!", 3)
        return nil
    end

    return query
end

function M.get_validated_input()
    local input

    vim.ui.input({ prompt = "Command: ", completion = "shellcmd" }, function(query)
        input = M.validate(query)
    end)

    return input
end

function M.send(query, win_name)
    if not vim.env.TMUX then
        clrscr("Not inside tmux session", 4)
        return
    elseif not pcall(require, "plenary.job") then
        clrscr("Dependency plenary.nvim not found", 4)
        return
    end

    query = query == nil and M.get_validated_input() or M.validate(query)
    if not query then
        return
    end

    win_name = win_name or "_console"

    local session = string.sub(call("tmux display -p '#S'"), 1, -2)

    local winid = call(format(
        --stylua: ignore
        [[
            tmux lsw | rg %s |
            awk 'BEGIN { getline; if (length == 0) { exit 1 } else { print $NF } }'
        ]],
        win_name
    ))

    if vim.v.shell_error > 0 then
        call(format("tmux new-window -d -c %s -a -t 'nvim' -n %s", vim.loop.cwd(), win_name))
        winid = call(format([[ tmux lsw -F '#I "#W"' | awk '$2 ~ /"%s"/ { print $1 }']], win_name))
    end

    vim.defer_fn(function()
        assert(M.tmux_send(session, winid:sub(1, -2), query) == 0)
    end, 500)
end

return M
