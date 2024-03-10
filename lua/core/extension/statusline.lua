local fn = vim.fn
local api = vim.api
local format = string.format

local stl = {}

function stl.is_truncated(fpath_len)
    fpath_len = fpath_len or string.len(fn.expand("%:p:."))
    local global_width = require("core.utils").get_width({ combined = true })
    return fpath_len > global_width / 2.5
end

function stl.get_filepath()
    local fpath = fn.expand("%:p:.")
    if stl.is_truncated() then
        fpath = format("%s", fn.pathshorten(fpath, 3))
    end
    return format(" %%<%s ", fpath)
end

function stl.get_fileperm()
    return vim.bo.readonly and "[RO] " or ""
end

function stl.get_filetype()
    local ftype = vim.bo.filetype
    return ftype == "" and "" or format(" 󰅩 %s ", ftype)
end

function stl.get_git_status()
    local dict = vim.b.gitsigns_status_dict
    if not dict or stl.is_truncated() then
        return ""
    end
    --stylua: ignore
    return dict.head ~= "" and
        format("(󰘬 %s)[+%s ~%s -%s] ",
            dict.head,
            dict.added,
            dict.changed,
            dict.removed)
        or ""
end

function stl.get_lsp_diagnostic_count()
    if stl.is_truncated() then
        return ""
    end

    local signs = require("plugin.lsp.diagnostics").signs
    local hl = "StatusLineDiagnostic"
    local dict = {
        { severity = 1, sign = signs.Error, hlgroup = hl .. "Error" },
        { severity = 2, sign = signs.Info, hlgroup = hl .. "Info" },
        { severity = 3, sign = signs.Warn, hlgroup = hl .. "Warn" },
        { severity = 4, sign = signs.Hint, hlgroup = hl .. "Hint" },
    }

    local diagnostics = ""
    for _, d in ipairs(dict) do
        local count = vim.tbl_count(vim.diagnostic.get(0, { severity = d.severity }))
        if count > 0 then
            diagnostics = format("%s %%#%s#%s%s", diagnostics, d.hlgroup, d.sign, count)
        end
    end

    return diagnostics .. "%#StatusLineNC# "
end

function stl.get_attached_sources()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    local null_sources = package.loaded["null-ls"] and require("null-ls.sources").get_available(vim.bo.filetype) or {}

    local active, index = {}, nil
    for i = 1, #clients do
        if clients[i].name == "null-ls" then
            index = i
        end
        active[i] = clients[i].name
    end
    for i = 1, #null_sources do
        active[#clients + i] = null_sources[i].name
    end

    if index then
        active[#active], active[index] = active[index], active[#active]
        active[#active] = nil
    end

    local attched = table.concat(active, ", ")
    return (#attched == 0 or stl.is_truncated()) and "" or string.format(" 󱘖  [%s] ", attched)
end

function stl.get_tshl_status()
    local buf = api.nvim_get_current_buf()
    local hl = require("vim.treesitter.highlighter")
    return hl.active[buf] and " 󰄬 " or ""
end

function stl.setup()
    StatusLine = setmetatable(stl, {
        __call = function(self)
            return table.concat({
                "%#StatusLineImp#",
                self.get_filepath(),
                "%#StatusLine#",
                self.get_fileperm(),
                self.get_git_status(),
                self.get_lsp_diagnostic_count(),
                "%=",
                "%#StatusLine#",
                self.get_filetype(),
                self.get_attached_sources(),
                "%#StatusLineInd#",
                self.get_tshl_status(),
                "%#StatusLine#",
            })
        end,
    })
    vim.opt.statusline = "%{%v:lua.StatusLine()%}"
end

stl.setup()
