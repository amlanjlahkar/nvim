local chartbl = {
    ["("] = { cclose = ")", after = "()<C-O>" },
    ["{"] = { cclose = "}", after = "{}<C-O>" },
    ["["] = { cclose = "]", after = "[]<C-O>" },
}
local M = {}

function M.should_autopair(copen)
    if not chartbl[copen] then
        vim.notify("autopair: character " .. copen .. " is not defined", 4)
        return
    end

    local ln = vim.fn.getline(".")
    local col = vim.fn.col(".")
    local cclose = chartbl[copen].cclose

    local pos_copen = ln:find(copen, col - 1, true)
    local pos_cclose = ln:find(cclose, 1, true)

    if not pos_cclose then
        return true
    end

    if not pos_copen then
        if pos_cclose < col then
            local next_cclose = ln:find(cclose, col + 1, true)
            return next_cclose and col > next_cclose or false
        else
            return ln:match("%" .. copen, -(pos_cclose - 1)) and true or false
        end
    end

    return pos_copen < pos_cclose
end

function M.autopair(char)
    if M.should_autopair(char) then
        local key = vim.api.nvim_replace_termcodes(chartbl[char].after, true, false, true)
        key = vim.fn.col(".") == vim.fn.col("$") and key .. "i" or key .. "h"
        vim.api.nvim_feedkeys(key, "n", false)
    else
        vim.api.nvim_feedkeys(char, "n", true)
    end
end

return M
