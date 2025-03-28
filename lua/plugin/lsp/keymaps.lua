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

-- workaround for efm directly pushing formatter stdout to buffer
local function fmt_with_edit()
    local win_state = vim.call("winsaveview")

    vim.lsp.buf.format({ name = "efm" })

    vim.cmd("edit!")
    vim.call("winrestview", win_state)
end

local function efm_fmt(buf)
    local matched_clients = vim.lsp.get_clients({ name = "efm", bufnr = buf })

    if vim.tbl_isempty(matched_clients) then
        return
    end

    local efm = matched_clients[1]
    local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
    local formatters = efm.config.settings.languages[ft]

    local matches = vim.tbl_filter(function(fmt)
        return not fmt.formatStdin
    end, formatters)

    if not vim.tbl_isempty(matches) then
        fmt_with_edit()
    else
        vim.lsp.buf.format({ name = "efm", timeout_ms = 5000, async = true })
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
                "<localleader>ff",
                function()
                    lsp_buf.format({
                        filter = function(client)
                            local exclude = { "efm", "sqls" }
                            return not vim.tbl_contains(exclude, client.name)
                        end,
                        timeout_ms = 5000,
                        async = true,
                    })
                end,
                opts(bufnr),
            },
            {
                "<localleader>fe",
                function()
                    efm_fmt(bufnr)
                end,
                opts(bufnr, "Format with efm"),
            },
        },

        nmap = {
            {
                "K",
                function()
                    lsp_buf.hover({ border = "single" })
                end,
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
                function()
                    lsp_buf.signature_help({ border = "single" })
                end,
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
                function()
                    vim.diagnostic.jump({ count = 1, float = false })
                end,
                opts(bufnr),
            },
            {
                "[d",
                function()
                    vim.diagnostic.jump({ count = -1, float = false })
                end,
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
