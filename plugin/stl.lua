local fn = vim.fn
local api = vim.api
local format = string.format

local stl = {}

function stl.is_truncated(fpath_len)
    fpath_len = fpath_len or string.len(fn.expand("%:p:."))
    local col_width = vim.opt.co:get()
    return fpath_len > col_width / 2.5
end

function stl.get_filepath()
    local fpath = fn.expand("%:p:.")
    if stl.is_truncated() then
        fpath = format("%s", fn.pathshorten(fpath, 3))
    end
    return format("%%<%s ", fpath)
end

function stl.is_readonly()
    return vim.bo.readonly and "[RO] " or ""
end

function stl.get_filetype()
    local ftype = vim.bo.ft
    return ftype == "" and "" or format("  %%#StatusLineImp#ft:%%#StatusLine# %s", ftype)
end

function stl.get_git_status()
    local signs_dict = vim.b.gitsigns_status_dict
    local fugitive_head = vim.call("FugitiveStatusline")

    if not stl.is_truncated() then
        if signs_dict then
            return signs_dict.head ~= ""
                    and format(
                        "(󰘬 %s)[+%s ~%s -%s] ",
                        signs_dict.head,
                        signs_dict.added,
                        signs_dict.changed,
                        signs_dict.removed
                    )
                or ""
        elseif fugitive_head ~= "" then
            return fugitive_head .. " "
        end
    end
    return ""
end

function stl.get_lsp_diagnostic_count()
    -- if stl.is_truncated() then
    --     return ""
    -- end

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
            diagnostics = format("%s %%#%s#%s%s ", diagnostics, d.hlgroup, d.sign, count)
        end
    end

    return diagnostics .. "%#StatusLine#"
end

function stl.get_attached_clients()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    local active, index = {}, nil
    for i = 1, #clients do
        if clients[i].name == "null-ls" then
            index = i
        end
        active[i] = clients[i].name
    end

    if index then
        active[#active], active[index] = active[index], active[#active]
        active[#active] = nil
    end

    local attched = table.concat(active, ", ")
    return (#attched == 0 or stl.is_truncated()) and ""
        or string.format("  %%#StatusLineImp#lsp:%%#StatusLine# [%s]", attched)
end

function stl.get_tshl_status()
    local buf = api.nvim_get_current_buf()
    local hl = require("vim.treesitter.highlighter")
    return hl.active[buf] and "󰄬  " or ""
end

function stl.setup()
    StatusLine = setmetatable(stl, {
        __call = function(self)
            return table.concat({
                "%#StatusLineImp#",
                self.get_filepath(),
                "%#StatusLine#",
                self.is_readonly(),
                self.get_git_status(),
                self.get_lsp_diagnostic_count(),
                "%=",
                self.get_filetype(),
                self.get_attached_clients(),
                "  (%l,%c%V)",
            })
        end,
    })
    vim.opt.statusline = "%{%v:lua.StatusLine()%}"
end

stl.setup()
