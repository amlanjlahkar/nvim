local lspc_available, nvim_lsp = pcall(require, "lspconfig")
if not lspc_available then
    return
end

local on_attach = function(client)
    require('config/lsp/handlers').on_attach()
    -- highlight symbol under cursor
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
        false)
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lscmp_available, lscmp = pcall(require, "cmp_nvim_lsp")
if lscmp_available then
    capabilities = lscmp.update_capabilities(capabilities)
end
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
    clangd = { cmd = { "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--compile-commands-dir=" } },

    sumneko_lua = require('config/lsp/lsconf/lua').setup
}

for name, opts in pairs(servers) do
    if type(opts) == "function" then
        opts()
    else
        local client = nvim_lsp[name]
        client.setup(vim.tbl_extend("force", {
            flags = { debounce_text_changes = 150 },
            on_attach = on_attach,
            capabilities = capabilities,
        }, opts))
    end
end


