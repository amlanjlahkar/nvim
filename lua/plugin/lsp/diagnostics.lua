local M = {
    border = "single",
    signs = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
    },
    virtual_prefix = " ",
}

function M:default_opts()
    return {
        signs = false,
        update_in_insert = false,
        underline = false,
        severity_sort = true,
        virtual_text = true,
        -- virtual_text = {
        --     spacing = 3,
        --     prefix = self.virtual_prefix,
        --     source = "if_many",
        -- },
        float = {
            focusable = true,
            style = "minimal",
            border = self.border,
            source = "if_many",
            header = "Diagnostic Info",
            format = function(d)
                local severity = {
                    ["E:"] = 1,
                    ["W:"] = 2,
                    ["I:"] = 3,
                    ["H:"] = 4,
                }
                for type, s in pairs(severity) do
                    if d.severity == s then
                        return string.format("%s %s", type, d.message)
                    end
                end
            end,
        },
    }
end

function M:setup_signs()
    for type, icon in pairs(self.signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

return M
