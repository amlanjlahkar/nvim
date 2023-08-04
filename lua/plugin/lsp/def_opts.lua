local M = {}

-- Handlers {{{1
function M.handlers()
    local lsp = vim.lsp
    return {
        ["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "single", style = "minimal" }),
        ["textDocument/signatureHelp"] = lsp.with(
            lsp.handlers.signature_help,
            { border = "single", style = "minimal" }
        ),
        -- ["textDocument/publishDiagnostics"] = lsp.with(
        --   lsp.diagnostic.on_publish_diagnostics,
        --   require("plugin.lsp.diagnostics"):default_opts()
        -- ),
    }
end
-- 1}}}

-- Capabilities {{{1
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
local is_cmp_available, cmp_nvim = pcall(require, "cmp_nvim_lsp")
if is_cmp_available then
    M.capabilities = cmp_nvim.default_capabilities(M.capabilities)
end
-- 1}}}

-- On_attach {{{1
-- Keymaps {{{2
function M.setup_keymaps(bufnr)
    local function check(action, fallback, opts)
        fallback = fallback or action
        opts = opts or {}
        local is_avail, tb = pcall(require, "telescope.builtin")
        if is_avail then
            tb["lsp_" .. action](opts)
        else
            vim.lsp.buf[fallback]()
        end
    end
    local lsp = vim.lsp.buf
    local key = require("core.utils.map")
    local opts = key.new_opts

    --stylua: ignore start
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    -- key.imap({ "<C-h>", lsp.signature_help })
    key.nmap({
        { "K", lsp.hover, opts(bufnr) },
        { "<leader>lr", lsp.rename, opts(bufnr) },
        { "<leader>la", lsp.code_action, opts(bufnr) },
        { "<leader>lh", lsp.signature_help, opts(bufnr) },
        { "<leader>lt", lsp.type_definition, opts(bufnr) },
        { "<leader>lf", vim.diagnostic.open_float, opts(bufnr) },
        { "<leader>ld", vim.diagnostic.setqflist, opts(bufnr) },
        { "]d", vim.diagnostic.goto_next, opts(bufnr) },
        { "[d", vim.diagnostic.goto_prev, opts(bufnr) },
        { "gd", function() check("definitions", "definition") end, opts(bufnr) },
        { "gi", function() check("implementations", "implementation") end, opts(bufnr) },
        { "gr", function() check("references") end, opts(bufnr) },
        { "<leader>ls", function() check("dynamic_workspace_symbols", "workspace_symbol", { fname_width = 40 }) end, opts(bufnr) },
    })
    --stylua: ignore end
end
-- 2}}}

function M.on_attach(client, bufnr)
    local api = vim.api
    if client.server_capabilities.documentHighlightProvider then
        ---@diagnostic disable-next-line: param-type-mismatch
        local is_defined, _ = pcall(vim.cmd, "silent hi LspReference")
        if is_defined then
            for _, ref in pairs({ "Text", "Read", "Write" }) do
                api.nvim_set_hl(0, "LspReference" .. ref, { link = "LspReference" })
            end
        end

        local au = api.nvim_create_autocmd
        local id = api.nvim_create_augroup("_lsp.on_attach", { clear = false })
        au("CursorHold", {
            group = id,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        au({ "CursorMoved", "InsertEnter" }, {
            group = id,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    local diagnostics = require("plugin.lsp.diagnostics")
    diagnostics:setup_signs()
    vim.diagnostic.config(diagnostics:default_opts())

    M.setup_keymaps(bufnr)
end
-- 1}}}

return M
