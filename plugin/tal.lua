local fn = vim.fn

local tal = {}

function tal.tabline()
    local t = ""
    for index = 1, fn.tabpagenr("$") do
        local winnr = fn.tabpagewinnr(index)
        local buflist = fn.tabpagebuflist(index)
        local bufnr = buflist[winnr]
        local bufname = fn.bufname(bufnr)

        if index == fn.tabpagenr() then
            t = t .. "%#TabLineSel#"
        else
            t = t .. "%#TabLine#"
        end

        t = t .. string.format(" %s:", index)

        if bufname ~= "" then
            local url = bufname:match("[%w]+://")
            t = url and t .. (url:gsub("://", " ")) or t .. string.format("%s ", fn.fnamemodify(bufname, ":t")):lower()
        else
            t = t .. string.format("%s ", vim.bo.ft):lower()
        end
    end

    t = t .. "%#TabLineFill#"
    return t
end

function tal.setup()
    function _G.set_tabline()
        return tal.tabline()
    end
    vim.opt.tabline = "%!v:lua.set_tabline()"
end

tal.setup()
