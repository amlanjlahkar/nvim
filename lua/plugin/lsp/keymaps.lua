local lsp_buf = vim.lsp.buf
local opts = require("utils.map").new_opts

local function telepick(action, fallback, picker_opts)
    fallback = fallback or action
    picker_opts = picker_opts or {}
    local is_avail, tb = pcall(require, "telescope.builtin")
    if is_avail then
        tb["lsp_" .. action](picker_opts)
    else
        lsp_buf[fallback]()
    end
end

local M = {}

function M.keymaps(bufnr)
    return {
        imap = {
            { "<C-s>", lsp_buf.signature_help },
        },

        nxmap = {
            {
                "<localleader>f",
                function()
                    lsp_buf.format({
                        filter = function(client)
                            local exclude = { "sqls" }
                            return not vim.tbl_contains(exclude, client.name)
                        end,
                        timeout_ms = 5000,
                        async = true,
                    })
                end,
                opts(bufnr),
            },
        },

        nmap = {
            {
                "K",
                lsp_buf.hover,
                opts(bufnr),
            },
            {
                "<localleader>r",
                lsp_buf.rename,
                opts(bufnr),
            },
            {
                "<localleader>a",
                lsp_buf.code_action,
                opts(bufnr),
            },
            {
                "<localleader>s",
                lsp_buf.signature_help,
                opts(bufnr),
            },
            {
                "<localleader>t",
                lsp_buf.type_definition,
                opts(bufnr),
            },
            {
                "<localleader>o",
                vim.diagnostic.open_float,
                opts(bufnr),
            },
            {
                "<localleader>d",
                vim.diagnostic.setloclist,
                opts(bufnr),
            },
            {
                "]d",
                vim.diagnostic.goto_next,
                opts(bufnr),
            },
            {
                "[d",
                vim.diagnostic.goto_prev,
                opts(bufnr),
            },
            {
                "gd",
                function()
                    telepick("definitions", "definition")
                end,
                opts(bufnr),
            },
            {
                "gi",
                function()
                    telepick("implementations", "implementation")
                end,
                opts(bufnr),
            },
            {
                "gr",
                function()
                    telepick("references")
                end,
                opts(bufnr),
            },
            {
                "<localleader>w",
                function()
                    telepick("dynamic_workspace_symbols", "workspace_symbol", { fname_width = 40 })
                end,
                opts(bufnr),
            },
            {
                "<localleader>i",
                function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
                end,
                opts(bufnr),
            },
        },
    }
end

return M
