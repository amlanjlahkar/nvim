local api = vim.api
local lsp = vim.lsp

local M = {}

-- Capabilities {{{1
M.capabilities = lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local is_cmp_available, cmp = pcall(require, "blink.cmp")
if is_cmp_available then
    M.capabilities = cmp.get_lsp_capabilities(M.capabilities)
end
-- 1}}}

-- On_attach {{{1
function M.on_attach(client, bufnr)
    local au = api.nvim_create_autocmd
    local id = api.nvim_create_augroup("_lsp.on_attach", { clear = false })

    if client:supports_method("textDocument/documentHighlight", bufnr) then
        if api.nvim_get_hl(0, { name = "LspReference" }) then
            for _, ref in pairs({ "Text", "Read", "Write" }) do
                api.nvim_set_hl(0, "LspReference" .. ref, { link = "LspReference" })
            end
        end

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

    if client:supports_method("textDocument/inlayHint", bufnr) then
        local inlay_hint = vim.lsp.inlay_hint

        au("InsertEnter", {
            group = id,
            buffer = bufnr,
            callback = function()
                if inlay_hint.is_enabled({ bufnr = bufnr }) then
                    inlay_hint.enable(false)
                end
            end,
        })
    end

    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
    local keymaps = require("plugin.lsp.keymaps").keymaps(bufnr)
    local key = require("utils.map")

    for mode, map in pairs(keymaps) do
        key[mode](map)
    end
end
-- 1}}}

return M
